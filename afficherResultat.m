function afficherResultat(video, Dx, D, C, pts, ptsY, truePts)


    %  figure
    screen = get(0,'screensize');
    screen(4) = screen(4) - 100;
    f = figure('Visible','off','Position',[0,0,screen(3),screen(4)]);
    
    %  components
    hprev = uicontrol('Style','pushbutton','String','Previous',...
          'Position',[screen(3) - 150,20,70,25],...
          'Callback',{@prevbutton_Callback});
    hnext = uicontrol('Style','pushbutton','String','Next',...
          'Position',[screen(3) - 150,60,70,25],...
          'Callback',{@nextbutton_Callback});
    hplay = uicontrol('Style','pushbutton','String','Play',...
          'Position',[screen(3) - 150,100,70,25],...
          'Callback',{@playbutton_Callback});
    ha = axes('Units','Pixels','Position',[50,70,screen(3)-60,screen(4)-100]); 

    set([f,ha,hprev,hnext,hplay], 'Units','normalized');

    i = 1;

    render;
    movegui(f,'northwest')
    set(f,'Visible','on');

    % callbacks
    function prevbutton_Callback(source,eventdata) 
        if (i > 1)
            i = i - 1;
        end
        render;
    end

    function nextbutton_Callback(source,eventdata) 
        if (i < length(ptsY))
            i = i + 1;
        end
        render;
    end

    function playbutton_Callback(source,eventdata) 
        % select area
        subplot(3, 4, [5:7 9:11]);
        
        % play
        for j = max(1, pts(i) - 24):min(pts(i) + 24, video.NumberOfFrames)
            imshow(read(video, j));
            title(int2str(j - pts(i)));
            drawnow
            pause(2/video.FrameRate);
        end
        
        % restore
        imshow(read(video, j));
        title('0');
    end

    % render
    function render
        
        % distance & pts
        subplot(3, 4, 1:4);
        hold off;
        stem(ptsY, ptsY*0+1, 'r.'); hold on;
        stem(truePts, truePts*0+.5, 'g:.');
        stem(ptsY(i), 1, 'r.', 'LineWidth', 3);
        plot(Dx*0+C, ':c');
        plot(Dx, D);
        xlim([min(Dx) max(Dx)]);
        
        % video
        subplot(3, 4, [5:7 9:11]);
        imshow(read(video, pts(i)));
        title('0');
        
    end
end