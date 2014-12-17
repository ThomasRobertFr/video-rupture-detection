function yCbCrVector = getVectorYCbCr(frame)
    nbIntensity = 256;
    nbLign = nbIntensity*3;
    yCbCrVector = zeros(nbLign, 1);
    [y, ~] = imhist(frame(:, :, 1));
    yCbCrVector(1:nbIntensity) = y;
    [Cb, ~] = imhist(frame(:, :, 2));
    yCbCrVector(nbIntensity + 1:nbIntensity * 2) = Cb;
    [Cr, ~] = imhist(frame(:, :, 3));
    yCbCrVector(nbIntensity * 2 + 1:end) = Cr;
end
