function cooccurrenceMatrice = getMatriceCooccurrence(vidObj, grayLevel) % GrayLevel is set by default to 8
    nbFrame = vidObj.NumberOfFrames
    cooccurrenceMatrice = zeros(grayLevel, grayLevel, nbFrame);
    for i=1:nbFrame
        frame = read(vidObj, i);
        cooccurrenceMatrice(:, :, i) = graycomatrix(rgb2gray(frame));
    end
end
