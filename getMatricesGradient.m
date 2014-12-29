function gradMatrices = getMatricesGradient(vidObj)
    nbFrame = 2000;
    gradMatrices = zeros(1, nbFrame);
    for i=1:nbFrame
        frame = read(vidObj, i);
        gradImg = getGradientImage(frame);
        gradMatrices(:, i) = gradImg(:);
    end
end
