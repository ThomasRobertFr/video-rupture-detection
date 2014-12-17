A1 = 10;
A2 = 10;

%signal = [randn(100,1)/102+2 ; randn(100,1)/102-1];

%%

vidObj = VideoReader('StarWars3.mp4');
signal = getMatriceRGB(vidObj)';

%% Calcul des ruptures avec une distance "différence de moyennes"

Ms = calculMsRandperm(A1, A2, signal, 100);
C = findC(Ms, 0.3);

D = calculDistances(A1, A2, signal, @meanDiffDistance);

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

%%

figure(2);
n = length(signal);
hold off;
plot(A1+1:n-A2, D/max(D));
hold all;
%plot(A1+1:n-A2, zones);
stem(points, points * 0 + 1);

%% Calcul des ruptures avec une distance par SVM

D2 = calculDistances(A1, A2, signal, @SVMDistance);

%%

[zones2, points2] = detectionRupture(D2, 0.7);
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

figure(2);
n = length(signal);
hold off;
%plot(signal);
hold all;
plot(A1+1:n-A2, D2);
plot(A1+1:n-A2, zones2);
stem(points2, points2 * 0 + 5);





