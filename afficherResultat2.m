function afficherResultat2(vidObj, points)
    vid = read(vidObj);
    mplay(vid);
    laFig = figure;
    play = uicontrol('Style','pushbutton','String','Play',...
        'Callback', 'uiresume(gcbf)', 'Position',[20,100,70,70]);
    for i = 1:length(points)
        subplot(3,1,1)
        image(read(vidObj, points(i) - 10))
        subplot(3,1,2)
        image(read(vidObj, points(i)))
        subplot(3,1,3)
        image(read(vidObj, points(i) + 10))
        set(play, 'Visible', 'on');
        uiwait(laFig);
    end
end
