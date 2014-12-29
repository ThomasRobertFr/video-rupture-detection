function yCbCrMatrice = getMatriceYCbCr(vidObj)
    nbIntensity = 256;
    nbLign = nbIntensity*3;
%     nbFrame = vidObj.NumberOfFrames
    nbFrame = 2000;
    yCbCrMatrice = zeros(nbLign, nbFrame);
    for i=1:nbFrame
        frame = read(vidObj, i);
        yCbCrMatrice(:, i) = getVectorYCbCr(frame);
    end
end
