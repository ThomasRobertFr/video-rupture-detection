function colorMatrice = getMatriceRGB(vidObj)
    nbIntensity = 256;
    nbLign = nbIntensity*3;
%     nbFrame = vidObj.NumberOfFrames;
    nbFrame = 2000;
    colorMatrice = zeros(nbLign, nbFrame);
    for i=1:nbFrame
        frame = read(vidObj, i);
        colorMatrice(:, i) = getVectorRGB(frame);
    end
end
