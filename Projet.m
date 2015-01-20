%% 1. Calcul des caractéristiques

compute = false;

% Vraies ruptures (secondes)
ptsApprox = [5 26.3 29.3 31.3 33.3 36.8 38.7 41.8 44.1 48 50 55.8 60.4 68.2 84.7];

% Chargement de la vidéo
vidObj = VideoReader('StarWars.mp4');
if (compute)
    [signal, ps] = loadVideoCaracts(vidObj, {@getVectorCooccurrence, @getGradientImage, @getVectorRGB, @getVectorYCbCr});
else
    load signal.mat
end
n = vidObj.NumberOfFrames;

% Régularisation des caractéristiques les unes par rapport aux autres
signal = regularizeCaracts(signal, ps);

%% 2. Prétraitement des caractéristiques

A1 = 20;
A2 = 20;
regulToMax = @(X) X/max(X);
calculDist = @(signal) regulToMax(calculDistances(A1, A2, signal, @meanDiffDistance));

titles  = {'signal', 'sqrt(signal)', 'log(signal*1e2+1)', 'log(signal*1e3+1)', 'log(signal*1e4+1)', 'log(signal*1e5+1)', 'log(signal*1e6+1)', 'log(signal*1e7+1)', 'log(signal*1e8+1)', 'log(signal*1e9+1)', 'log(signal*1e10+1)', 'signal .* (signal < 1e-4) + 1e-4 .* (signal >= 1e-4)'};
signals = cellfun(@eval, titles, 'UniformOutput', false);
datay   = cellfun(calculDist, signals, 'UniformOutput', false);
datax   = (A1+1:n-A2)/vidObj.FrameRate;

signalsRegulX = 0:.001:1;
reguls = cellfun(@(s) strrep(s, 'signal', 'signalsRegulX'), titles, 'UniformOutput', false);
signalsRegulYs = cellfun(@eval, reguls, 'UniformOutput', false);

signalAndDistancesGUI(signals, signalsRegulX, signalsRegulYs, datax, datay, ptsApprox, titles);

%% 3. Test de différentes fenêtres

X = log(signal*1e9+1);

regulToMax = @(X) X/max(X);
calculDist = @(A) regulToMax(calculDistances(A, A, X, @meanDiffDistance));
calculX = @(A) (A+1:n-A)/vidObj.FrameRate;

As     = {4, 7, 10, 13, 15, 17, 20, 24, 28, 31, 34};
titles = strcat(cellfun(@(A) 'A1 = A2 = ', As, 'UniformOutput', false), cellfun(@num2str, As, 'UniformOutput', false));
datay  = cellfun(calculDist, As, 'UniformOutput', false);
datax  = cellfun(calculX, As, 'UniformOutput', false);

distancesGUI(datax, datay, ptsApprox, titles);

%% 4. Test de différentes fenêtres pour A2

X = log(signal*1e9+1);
A1 = 20;

regulToMax = @(X) X/max(X);
calculDist = @(A2) regulToMax(calculDistances(A1, A2, X, @meanDiffDistance));
calculX = @(A2) (A1+1:n-A2)/vidObj.FrameRate;

As     = {4, 7, 10, 13, 15, 17, 20, 24, 28, 31, 34};
titles = strcat(cellfun(@(A) 'A1 = 20 / A2 = ', As, 'UniformOutput', false), cellfun(@num2str, As, 'UniformOutput', false));
datay  = cellfun(calculDist, As, 'UniformOutput', false);
datax  = cellfun(calculX, As, 'UniformOutput', false);

distancesGUI(datax, datay, ptsApprox, titles);

%% 5. Calcul de C avec la méthode la p-valeur
% Très mauvais résultats avec 200 tirages, on a C = .46 pour p = 0, donc
% aucune chance d'atteindre les valeurs supérieures, qui sont pourtant bien
% meilleures.

X = log(signal*1e9+1);
A1 = 20;
A2 = 28;

if (compute)
    Ms = calculMsRandperm(A1, A2, X, 200);
else
    load Ms
end
D = calculDistances(A1, A2, X, @meanDiffDistance);
Ms = Ms / max(D);
Cs = findC(Ms, 0:.01:1);
figure;
subplot(2,1,1);
plot(Ms);
title('Ms');
subplot(2,1,2);
plot(Cs);
title('Cs');
xlabel('p');

%% 6. Calcul des ruptures avec une distance "différence de moyennes"

X = log(signal*1e9+1);
A1 = 20;
A2 = 28;
C = .6;

D = calculDistances(A1, A2, X, @meanDiffDistance);
D = D / max(D);
Dx = (A1+1:n-A2)/vidObj.FrameRate;

[zones, points] = detectionRupture(D, C);
points = points + A1 - 1;

afficherResultat(vidObj, Dx, D, C, points, points/vidObj.FrameRate, ptsApprox)

%% 7. Calcul des ruptures avec une distance par SVM

X = log(signal*1e9+1);
A1 = 20;
A2 = 28;
C = .8;

if (compute)
    D = calculDistances(A1, A2, X, @SVMDistance);
else
    load DSVM;
end

Dx = (A1+1:n-A2)/vidObj.FrameRate;

[zones, points] = detectionRupture(D, C);
points = points + A1 - 1;

afficherResultat(vidObj, Dx, D, C, points, points/vidObj.FrameRate, ptsApprox)
