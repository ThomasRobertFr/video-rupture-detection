function vect = getVectorCooccurrence(frame)
    cooccurrenceMatrice = graycomatrix(rgb2gray(frame));
    [n, p] = size(cooccurrenceMatrice);
    vect = zeros(n*p, 1);
    for i=1:p
        vect(i*n-n+1:i*n) = cooccurrenceMatrice(:, i);
    end
end