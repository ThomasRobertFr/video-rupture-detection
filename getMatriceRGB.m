function colorMatrice = getMatriceRGB(frames)
    nbIntensity = 256;
    nbLign = nbIntensity*3;
    nbFrame = size(frames, 4);
    colorMatrice = zeros(nbLign, nbFrame);
    for i=1:nbFrame
        colorMatrice(:, i) = getVectorRGB(frames(:, :, :, i));
    end
end