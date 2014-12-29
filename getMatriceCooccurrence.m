function matCoo = getMatriceCooccurrence(vidObj)
    % GrayLevel is set by default to 8
    % diffs is a vector containing the difference between 2 consecutives
    % frames. For example : diffs(2) is the difference between frame 2
    % and frame 1. diffs(1) always equals 0.
%     nbFrame = vidObj.NumberOfFrames;
    nbFrame = 2000;
    grayScale = 64;
    matCoo = zeros(grayScale, nbFrame);
    for i=1:nbFrame
        frame = read(vidObj, i);
        vect = getVectorCooccurrence(frame);
        matCoo(:, i) = vect;
    end
end
