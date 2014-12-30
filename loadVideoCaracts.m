function [X, ps] = loadVideoCaracts(video, vectorFunctions)

% determine n, p
n = video.NumberOfFrames;
ps = zeros(1, length(vectorFunctions));
frame = read(video, 1);
for j = 1:length(vectorFunctions)
    ps(j) = length(vectorFunctions{j}(frame));
end
p = sum(ps);

% init output
X = zeros(n, p);

% loop on frames
for i=1:n
    frame = read(video, i);
    % loop on carac functions
    for j = 1:length(vectorFunctions)
        inds = ( sum(ps(1:j-1)) + 1 ) : ( sum(ps(1:j)) );
        X(i,inds) = vectorFunctions{j}(frame);
    end
end