function mat = getCooccurrencesMatToVect(vidObj)
    % GrayLevel is set by default to 8
    % diffs is a vector containing the difference between 2 consecutives
    % frames. For example : diffs(2) is the difference between frame 2
    % and frame 1. diffs(1) always equals 0.
    nbFrame = vidObj.NumberOfFrames;
    grayScale = 64;
    mat = zeros(grayScale, nbFrame);
    for i=1:nbFrame
        frame = read(vidObj, i);
        vect = getVectorCooccurrence(frame);
        mat(:, i) = vect;
    end
end
