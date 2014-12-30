%% Constantes

A1 = 15;
A2 = 15;
ptsApprox = [0 5 10 26.3 29.3 31.3 33.3 36.8 38.7 41.8 44.1 48 50 55.8 60.4 68.2 84.7];

%% Calcul des caractéristiques

%vidObj = VideoReader('StarWars.mp4');
%[signal, ps] = loadVideoCaracts(vidObj, {@getVectorCooccurrence, @getGradientImage, @getVectorRGB, @getVectorYCbCr});

load signal.mat
signal = regularizeCaracts(signal, ps);

%% Prétraitement des caractéristiques & calcul de distances

regulToMax = @(X) X/max(X);
calculDist = @(signal) regulToMax(calculDistances(A1, A2, signal, @meanDiffDistance));

i = 1;
signals = {}; titles = {};
signals{i}  = signal; titles{i} = 'signal'; i = i + 1;
signals{i}  = sqrt(signal); titles{i} = 'sqrt(signal)'; i = i + 1;
signals{i}  = log(signal*1e2+1); titles{i} = 'log(signal*1e2+1)'; i = i + 1;
signals{i}  = log(signal*1e3 + 1); titles{i} = 'log(signal*1e3+1)'; i = i + 1;
signals{i}  = log(signal*1e4 + 1); titles{i} = 'log(signal*1e4+1)'; i = i + 1;
signals{i}  = log(signal*1e5 + 1); titles{i} = 'log(signal*1e5+1)'; i = i + 1;
signals{i}  = log(signal*1e6 + 1); titles{i} = 'log(signal*1e6+1)'; i = i + 1;
signals{i}  = log(signal*1e7 + 1); titles{i} = 'log(signal*1e7+1)'; i = i + 1;
datay = cellfun(calculDist, signals, 'UniformOutput', false);
datax = (A1+1:vidObj.NumberOfFrames - A2)/vidObj.FrameRate;

distancesGUI(signals, datax, datay, ptsApprox, titles);

%% Calcul des ruptures avec une distance "différence de moyennes"

signal2 = log(signal*1e5 + 1);
D = calculDistances(A1, A2, signal, @meanDiffDistance);
C = 10;

[zones, points] = detectionRupture(D, C);
points = points + A1 - 1

%% Affichage du résultat

for i = 1:length(points)
    subplot(3,1,1)
    image(read(vidObj, points(i) - 10))
    subplot(3,1,2)
    image(read(vidObj, points(i)))
    subplot(3,1,3)
    image(read(vidObj, points(i) + 10))
    pause
end

figure(2);
n = length(signal);
hold off;
plot(A1+1:n-A2, D/max(D));
hold all;
plot(A1+1:n-A2, (A1+1:n-A2)*0+C/max(D));
stem(points, points * 0 + 1, '.');

%% Calcul des ruptures avec une distance par SVM

D2 = calculDistances(A1, A2, signal, @SVMDistance);

%%

C2 = 1.8;
[zones2, points2] = detectionRupture(D2, C2);
points2 = points2 + A1 - 1

%% Affichage du résultat

for i = 1:length(points)
    subplot(3,1,1)
    image(read(vidObj, points2(i) - 10))
    subplot(3,1,2)
    image(read(vidObj, points2(i)))
    subplot(3,1,3)
    image(read(vidObj, points2(i) + 10))
    pause
end

%%

figure(2);
n = length(signal);
hold off;
%plot(signal);
hold all;
plot(A1+1:n-A2, D2./max(D2));
plot(A1+1:n-A2, (A1+1:n-A2)*0+C2);
stem(points2, points2 * 0 + 1, '.');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Bout de code pour plusieurs caract %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Calcul des caractéristiques
% signal = cell(1, 4);
% C = cell(1, 4);
% D = cell(1, 4);
% 
% vidObj = VideoReader('StarWars.mp4');
% 
% signal{1} = getMatriceRGB(vidObj)';
% signal{2} = getMatriceYCbCr(vidObj)';
% signal{3} = getMatriceCooccurrence(vidObj)';
% signal{4} = getMatricesGradient(vidObj)';
% 
%% Calcul des ruptures avec une distance "différence de moyennes"
% 
% for i=1:length(signal)
%     Ms = calculMsRandperm(A1, A2, signal{i}, 100);
%     C{i} = findC(Ms, 0.4);
%     D{i} = calculDistances(A1, A2, signal{i}, @meanDiffDistance);
% end
% 
% [zones, points] = detectionRuptureMulti(D, C);
% points = points + A1 - 1;
%
%% Affichage du résultat
%
% afficherResultat2(vidObj, points)


