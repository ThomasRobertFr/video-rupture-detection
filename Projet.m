A1 = 15;
A2 = 15;

%signal = [randn(100,1)/102+2 ; randn(100,1)/102-1];

%%

vidObj = VideoReader('StarWars.mp4');
frames = read(vidObj, [1,Inf]);
signal = getMatriceRGB(frames)';

%%

Ms = calculMsRandperm(A1, A2, signal, 100);

%%

C = findC(Ms, 0.3);

D = calculDifference(A1, A2, signal);

[zones, points] = detectionRupture(D, C);
points = points + A1 - 1

%%

for i = 1:length(points)
    subplot(3,1,1)
    image(frames(:,:,:,points(i)-10))
    subplot(3,1,2)
    image(frames(:,:,:,points(i)))
    subplot(3,1,3)
    image(frames(:,:,:,points(i)+10))
    pause
end

%%

figure(2);
n = length(signal);
hold off;
%plot(signal);
hold all;
plot(A1+1:n-A2, D);
%plot(A1+1:n-A2, zones);
%stem(points, points * 0 + 5);

%%






