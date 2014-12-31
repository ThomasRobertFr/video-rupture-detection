function signalAndDistancesGUI(signals, signalsRegulX, signalsRegulYs, datax, datay, stems, titles)

    % figure
    screen = get(0,'screensize');
    screen(4) = screen(4) - 100;
    f = figure('Visible','off','Position',[0,0,screen(3),screen(4)]);

    % components
    hprev = uicontrol('Style','pushbutton','String','Previous',...
          'Position',[screen(3)/2 - 50,10,70,25],...
          'Callback',{@prevbutton_Callback});
    hnext = uicontrol('Style','pushbutton','String','Next',...
          'Position',[screen(3)/2 + 50,10,70,25],...
          'Callback',{@nextbutton_Callback});
    ha = axes('Units','Pixels','Position',[50,70,screen(3)-60,screen(4)-80]); 

    set([f,ha,hprev,hnext], 'Units','normalized');

    currentI = 1;

    render;
    movegui(f,'northwest')
    set(f,'Visible','on');

    % callbacks
    function prevbutton_Callback(source,eventdata) 
        if (currentI > 1)
            currentI = currentI - 1;
        end
        render;
    end

    function nextbutton_Callback(source,eventdata) 
        if (currentI < length(datay))
            currentI = currentI + 1;
        end
        render;
    end

    % render
    function render
        subplot(2,4,1:3);
        imagesc(signals{currentI});
        colorbar;
        title(titles{currentI});
        
        subplot(2,4,4);
        plot(signalsRegulX, signalsRegulYs{currentI});
        xlim([min(signalsRegulX),max(signalsRegulX)]);
        ylims = [min(signalsRegulYs{currentI}),max(signalsRegulYs{currentI})];
        ylims(2) = ylims(2) + (ylims(2) - ylims(1))*0.05;
        ylim(ylims);
        title('Régularisation');
        
        subplot(2,4,5:8);
        hold off;
        stem(stems, stems*0+1, 'r.');
        hold on;
        plot(datax, datay{currentI});
        title('Distances');
        
        set(f,'Name',titles{currentI});
    end
 
end 