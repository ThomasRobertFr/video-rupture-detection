function afficherResultat(vidObj, points)
    vid = read(vidObj);
    laFig = figure;
    play = uicontrol('Style','pushbutton','String','Play',...
        'Callback', 'uiresume(gcbf)', 'Position',[20,100,70,70]);
    init = 1;
    for i = 1:length(points)
        subplot(4,1,1)
        image(read(vidObj, points(i) - 10))
        subplot(4,1,2)
        image(read(vidObj, points(i)))
        subplot(4,1,3)
        image(read(vidObj, points(i) + 10))
        for frame = init : points(i)
            set(play, 'Visible', 'off');
            subplot(4,1,4);
            imshow(vid(:,:,:,frame));
            drawnow
            for j = 1:100
                towait = ones(200, 200) * ones(200, 200);
            end
        end
        set(play, 'Visible', 'on');
        uiwait(laFig);
        init = points(i) + 1;
    end
    for frame = init : 2000
        set(play, 'Visible', 'off');
        subplot(4,1,4);
        imshow(vid(:,:,:,frame));
        drawnow
%         for j = 1:100
%             towait = ones(200, 200) * ones(200, 200);
%         end
    end
end