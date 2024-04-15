%% 230324, make figure on the effect of CK on amplitude, IPI (figure used in Fig 7)
% use after "toRun_240324_ckFig7S.m"

%% plot just dot, not cloud; vertical plot; also not as subplot

xx=10;
numbertoplot=1:xx;
legendlabel={'-', '+', '-', '+', '-', '+', '-', '+', '-', '+'};
legendlabel2={'Arp3','CBD','FMNL1','Lifeact','SHIP1'};

%%
figure('Position',[scrsz(3)*0.2 scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.6],'PaperPosition',[0.25 2.5 xx*0.2 1.5 ]);

for k=1:xx
    Intensity_2=Fig7_intensity{numbertoplot(k)};
    Intensity=Intensity_2(:,1); 
    % Intensity=Intensity_2(:,2); %for normalized plot
    
    center=-0.5+k;
    if mod(k, 2) == 0  % Number is even, color is purple
        rain_dot_box_plot_v(Intensity, cb(3,:), [0 4], center);%purple
    else
        rain_dot_box_plot_v(Intensity, cb(9,:), [0 4], center);%gray
    end
    hold on

    set(gca, 'YLim', [0.6 4]);
    %set(gca, 'YLim', [0 4]); %for normalized plot

    box off

    % s1=round(mean(Intensity)*10)/10;
    % s2=round(std(Intensity)*10)/10;
    s3=length(Intensity);
    if k==0
        stat_string=['n=' num2str(s3)];
    else
        stat_string=[num2str(s3)];
    end

    % stat_string=[num2str(s1) char(177) num2str(s2) ', n=' num2str(s3)];
    xL=xlim;
    yL=ylim;
    text(center,yL(2),stat_string,'HorizontalAlignment','center','VerticalAlignment','top','FontSize',5)
    hold on
end

box off

hold off;
set(gca, 'YTick', 1:1:3); % Set x-tick positions
set(gca, 'XTick', 0.5:1:xx-0.5); % Set x-tick positions
set(gca,'XTickLabel',legendlabel,'fontsize',6)
y2=-0.1;
text(1:2:xx, [y2 y2 y2 y2 y2], legendlabel2, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 6);
ylabel('Peak Intensity','FontSize',6);
xlabel('_','FontSize',6);

print('-depsc','-r300', 'Fig7_int_dot_v.eps');

% print('-depsc','-r300', 'Fig7_int_norm_dot_v.eps');