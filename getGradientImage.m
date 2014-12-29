function gradIm = getGradientImage(img)
    imgGray = rgb2gray(img)/255;
%     fil1 = fspecial('sobel');
%     fil2 = -fil1';
    fil1 = [1 0; 0 -1];
    fil2 = [0 1; -1 0];
    Gx = filter2(fil1, imgGray);
    Gy = filter2(fil2, imgGray);
    gradIm = norm(sqrt(Gx.*Gx + Gy.*Gy));
end
