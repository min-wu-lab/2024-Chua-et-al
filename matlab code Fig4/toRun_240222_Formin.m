%
% % make figure on formin,
% % threshold 1.15
% %
clear all


%%
excelname='Fig1D_1H FMNL1 precedes Arp3';
experiment='Fmn_arp_c1';
channel1 = readmatrix(excelname,'Sheet','Channel1');
timeinterval=readmatrix(excelname,'Sheet','time interval');

script_BatchProcess_IPI

p2p_allconditions{3}=p2p_all_as_matrix;
intensity_allconditions{3}=peakI_as_matrix;


excelname='Fig2B FMNL1CT_ARP3';
experiment='FmnCT_arp_c1';
channel1 = readmatrix(excelname,'Sheet','Channel1');
timeinterval=readmatrix(excelname,'Sheet','time interval');

script_BatchProcess_IPI

p2p_allconditions{4}=p2p_all_as_matrix;
intensity_allconditions{4}=peakI_as_matrix;

excelname='Fig1F 1H 2A FMNL1CA_Arp3';
experiment='CAFmn_arp_c1';
channel1 = readmatrix(excelname,'Sheet','Channel1');
timeinterval=readmatrix(excelname,'Sheet','time interval');

script_BatchProcess_IPI

p2p_allconditions{5}=p2p_all_as_matrix;
intensity_allconditions{5}=peakI_as_matrix;
%
excelname='T126D Arp3 Jerry_Cheesan_combined';
experiment='FmnT126D_arp_c1';
channel1 = readmatrix(excelname,'Sheet','Channel1');
timeinterval=readmatrix(excelname,'Sheet','time interval');

script_BatchProcess_IPI

p2p_allconditions{6}=p2p_all_as_matrix;
intensity_allconditions{6}=peakI_as_matrix;


excelname='V281E Arp3 correlation Jerry_CheeSan_combined';
experiment='FmnV281E_CJ_TCS';
channel1 = readmatrix(excelname,'Sheet','Channel1');
timeinterval=readmatrix(excelname,'Sheet','time interval');

script_BatchProcess_IPI

p2p_allconditions{7}=p2p_all_as_matrix;
intensity_allconditions{7}=peakI_as_matrix;

excelname='Fig2F FMNL1V281E alone';
experiment='FmnV281E';
channel1 = readmatrix(excelname,'Sheet','Channel1');
timeinterval=readmatrix(excelname,'Sheet','time interval');

script_BatchProcess_IPI

p2p_allconditions{8}=p2p_all_as_matrix;
intensity_allconditions{8}=peakI_as_matrix;

excelname='V281E Arp3 correlation Jerry';
experiment='FmnV281E_CJ';
channel1 = readmatrix(excelname,'Sheet','Channel1');
timeinterval=readmatrix(excelname,'Sheet','time interval');

script_BatchProcess_IPI

p2p_allconditions{9}=p2p_all_as_matrix;
intensity_allconditions{9}=peakI_as_matrix;


excelname='Fig2F Fmnl1V281E A36';
experiment='FmnV281E_arp_c1';
channel1 = readmatrix(excelname,'Sheet','Channel1');
timeinterval=readmatrix(excelname,'Sheet','time interval');

script_BatchProcess_IPI

p2p_allconditions{10}=p2p_all_as_matrix;
intensity_allconditions{10}=peakI_as_matrix;


%%
numbertoplot=[1, 3:7]; % which dataset to plot
[cb] = cbrewer2('qual','Set3',10,'pchip');
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*0.2 scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.6],'PaperPosition',[0.25 2.5 5 10]);
for k=1:6
    period=p2p_allconditions{numbertoplot(k)};
    if ~isempty(period)

        subplot(8,1,k), raincloud_plot(period, cb(k,:), [-10 100]);
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
print('-depsc','-r300', 'formin_IPI.eps');

%%
numbertoplot=[1, 3:7]; % which dataset to plot
[cb] = cbrewer2('qual','Set3',10,'pchip');
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*0.2 scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.6],'PaperPosition',[0.25 2.5 4 6]);

for k=1:6
    Intensity=intensity_allconditions{numbertoplot(k)};
    if ~isempty(Intensity)

        subplot(6,1,k), raincloud_plot(Intensity, cb(1,:), [0 4]);
        if k<6
            set(gca, 'XTickLabel', []);
        end
        s1=round(mean(Intensity)*10)/10;
        s2=round(std(Intensity)*10)/10;
        s3=length(Intensity);
        stat_string=[num2str(s1) char(177) num2str(s2) ', n=' num2str(s3)];
        xL=xlim;
        yL=ylim;
        text(0.99*xL(2),0.99*yL(2),stat_string,'HorizontalAlignment','right','VerticalAlignment','top')
        hold on
    end

end
xlabel('Intensity');
print('-depsc','-r300', 'formin_intensity.eps');

save('formin.mat','intensity_allconditions','p2p_allconditions');
