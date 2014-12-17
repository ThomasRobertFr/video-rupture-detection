function diff = get2MatricesCooccurrenceDiff(frame1, frame2, grayLevel) % GrayLevel is set by default to 8
    cooccurrenceMatrice1 = graycomatrix(rgb2gray(frame1));
    cooccurrenceMatrice2 = graycomatrix(rgb2gray(frame2));
    diff = norm(abs(cooccurrenceMatrice1 - cooccurrenceMatrice2));
end
