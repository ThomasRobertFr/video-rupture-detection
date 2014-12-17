function diffs = getCooccurrencesDiff(vidObj, grayLevel)
    % GrayLevel is set by default to 8
    % diffs is a vector containing the difference between 2 consecutives
    % frames. For example : diffs(2) is the difference between frame 2
    % and frame 1. diffs(1) always equals 0.
    nbFrame = vidObj.NumberOfFrames
    diffs = zeros(1, nbFrame);
    frame1 = read(vidObj, 1);
    for i=2:nbFrame
        frame2 = read(vidObj, i);
        diff = get2MatricesCooccurrenceDiff(frame1, frame2, grayLevel);
        diffs(1, i) = diff;
        frame1 = frame2;
    end
end
