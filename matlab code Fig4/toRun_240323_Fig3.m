% to make composite figure based on arp/formin IPI mixed data
p2p_figure_Arp_or_formin(1)=p2p_by_arp(1);
p2p_figure_Arp_or_formin(3)=p2p_by_formin(3);
p2p_figure_Arp_or_formin(4)=p2p_by_arp(4);
p2p_figure_Arp_or_formin(5)=p2p_by_formin(5);
p2p_figure_Arp_or_formin(6)=p2p_by_arp(6);
p2p_figure_Arp_or_formin(7)=p2p_by_formin(7);


save('figure_IPI.mat','p2p_figure_Arp_or_formin','p2p_by_arp', 'p2p_by_formin');


numbertoplot=[1, 3:7];
[cb] = cbrewer2('qual','Set3',10,'pchip');
scrsz = get(0,'ScreenSize');
%figure('Position',[scrsz(3)*0.2 scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.6],'PaperPosition',[0.25 2.5 5 10]);
figure('Position',[scrsz(3)*0.2 scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.6],'PaperPosition',[0.25 2.5 4 6]);
for k=1:6

    period=p2p_figure_Arp_or_formin{numbertoplot(k)};
    if ~isempty(period)

        subplot(6,1,k), raincloud_plot(period, cb(3,:), [-10 100]);
        if k<6
            set(gca, 'XTickLabel', []);
        end
        s1=round(mean(period)*10)/10;
        s2=round(std(period)*10)/10;
        s3=length(period);
        stat_string=[num2str(s1) char(177) num2str(s2) ', n=' num2str(s3)];
        xL=xlim;
        yL=ylim;
        text(0.99*xL(2),0.99*yL(2),stat_string,'HorizontalAlignment','right','VerticalAlignment','top')
        hold on
    end
end
xlabel('IPI (sec)');
print('-depsc','-r300', 'figure_IPI.eps');
