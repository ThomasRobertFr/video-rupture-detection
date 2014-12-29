function vect = getVectorCooccurrence(frame)
    cooccurrenceMatrice = graycomatrix(rgb2gray(frame));
    vect = cooccurrenceMatrice(:);
end