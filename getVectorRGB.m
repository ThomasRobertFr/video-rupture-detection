function colorVector = getVectorRGB(frame)
    nbIntensity = 256;
    nbLign = nbIntensity*3;
    colorVector = zeros(nbLign, 1);
    [r, ~] = imhist(frame(:, :, 1));
    colorVector(1:nbIntensity) = r;
    [g, ~] = imhist(frame(:, :, 2));
    colorVector(nbIntensity + 1:nbIntensity * 2) = g;
    [b, ~] = imhist(frame(:, :, 3));
    colorVector(nbIntensity * 2 + 1:end) = b;
end