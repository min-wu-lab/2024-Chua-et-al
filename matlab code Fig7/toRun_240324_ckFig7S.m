%% 230324, make figure on the effect of CK on amplitude, IPI (figure used in Fig 7 7S)

%% threshold use 1.05 (if use 1.15, after drug very few data points)
%


%% effect of Arp
excelname='CBD_Arp3_CK666 20240325';
experiment='C_arp_ck_arp'; %use a shorter name to save all the plots
channel1 = readmatrix(excelname,'Sheet','Channel2');

[~,p2p_beforeDrug,p2p_afterDrug,...
    peakI_beforeDrug,peakI_afterDrug]=script_BatchProcess_IPI_v2(excelname,experiment,channel1);

%before
Fig7_p2p{1}=p2p_beforeDrug;
Fig7_intensity{1}=peakI_beforeDrug;

%after
Fig7_p2p{2}=p2p_afterDrug;
Fig7_intensity{2}=peakI_afterDrug;

%% effect on Cbd
excelname='CBD_Arp3_CK666 20240325';
experiment='C_arp_ck_C'; %use a shorter name to save all the plots
channel1 = readmatrix(excelname,'Sheet','Channel1');

[~,p2p_beforeDrug,p2p_afterDrug,...
    peakI_beforeDrug,peakI_afterDrug]=script_BatchProcess_IPI_v2(excelname,experiment,channel1);

%before
Fig7_p2p{3}=p2p_beforeDrug;
Fig7_intensity{3}=peakI_beforeDrug;

%after
Fig7_p2p{4}=p2p_afterDrug;
Fig7_intensity{4}=peakI_afterDrug;

%% effect on FMNL1
excelname='FMNL1_Arp3_CK666 20240320';
experiment='F_Arp3_ck_fmn'; %use a shorter name to save all the plots
channel1 = readmatrix(excelname,'Sheet','Channel1');

[~,p2p_beforeDrug,p2p_afterDrug,...
    peakI_beforeDrug,peakI_afterDrug]=script_BatchProcess_IPI_v2(excelname,experiment,channel1);

%before
Fig7_p2p{5}=p2p_beforeDrug;
Fig7_intensity{5}=peakI_beforeDrug;

%after
Fig7_p2p{6}=p2p_afterDrug;
Fig7_intensity{6}=peakI_afterDrug;

%% effect on arp (in the FMNL1 dataset)
excelname='FMNL1_Arp3_CK666 20240320';
experiment='F_Arp3_ck_arp'; %use a shorter name to save all the plots
channel1 = readmatrix(excelname,'Sheet','Channel2');

[~,p2p_beforeDrug,p2p_afterDrug,...
    peakI_beforeDrug,peakI_afterDrug]=script_BatchProcess_IPI_v2(excelname,experiment,channel1);

%before
Fig7_p2p{1}=[Fig7_p2p{1}; p2p_beforeDrug];
Fig7_intensity{1}=[Fig7_intensity{1};peakI_beforeDrug];

%after
Fig7_p2p{2}=[Fig7_p2p{2};p2p_afterDrug];
Fig7_intensity{2}=[Fig7_intensity{2};peakI_afterDrug];

%% effect on lifeact

excelname='LifeAct_Arp3_CK666 20240402';
experiment='L_Arp3_ck_L'; %use a shorter name to save all the plots
channel1 = readmatrix(excelname,'Sheet','Channel1');

[~,p2p_beforeDrug,p2p_afterDrug,...
    peakI_beforeDrug,peakI_afterDrug]=script_BatchProcess_IPI_v2(excelname,experiment,channel1);

%before
Fig7_p2p{7}=p2p_beforeDrug;
Fig7_intensity{7}=peakI_beforeDrug;

%after
Fig7_p2p{8}=p2p_afterDrug;
Fig7_intensity{8}=peakI_afterDrug;

%% effect on arp (in the lifeact dataset)
excelname='LifeAct_Arp3_CK666 20240402';
experiment='L_Arp3_ck__Arp'; %use a shorter name to save all the plots
channel1 = readmatrix(excelname,'Sheet','Channel2');

[~,p2p_beforeDrug,p2p_afterDrug,...
    peakI_beforeDrug,peakI_afterDrug]=script_BatchProcess_IPI_v2(excelname,experiment,channel1);

%before
Fig7_p2p{1}=[Fig7_p2p{1}; p2p_beforeDrug];
Fig7_intensity{1}=[Fig7_intensity{1};peakI_beforeDrug];

%after
Fig7_p2p{2}=[Fig7_p2p{2};p2p_afterDrug];
Fig7_intensity{2}=[Fig7_intensity{2};peakI_afterDrug];

%% effect on ship

excelname='SHIP1 Arp ck666 20240322';
experiment='S_Arp3_ck_ship'; %use a shorter name to save all the plots
channel1 = readmatrix(excelname,'Sheet','Channel1');

[~,p2p_beforeDrug,p2p_afterDrug,...
    peakI_beforeDrug,peakI_afterDrug]=script_BatchProcess_IPI_v2(excelname,experiment,channel1);

%before
Fig7_p2p{9}=p2p_beforeDrug;
Fig7_intensity{9}=peakI_beforeDrug;

%after
Fig7_p2p{10}=p2p_afterDrug;
Fig7_intensity{10}=peakI_afterDrug;

%% effect on arp (in the ship dataset)
excelname='SHIP1 Arp ck666 20240322';
experiment='S_Arp3_ck__Arp'; %use a shorter name to save all the plots
channel1 = readmatrix(excelname,'Sheet','Channel2');

[~,p2p_beforeDrug,p2p_afterDrug,...
    peakI_beforeDrug,peakI_afterDrug]=script_BatchProcess_IPI_v2(excelname,experiment,channel1);

%before
Fig7_p2p{1}=[Fig7_p2p{1}; p2p_beforeDrug];
Fig7_intensity{1}=[Fig7_intensity{1};peakI_beforeDrug];

%after
Fig7_p2p{2}=[Fig7_p2p{2};p2p_afterDrug];
Fig7_intensity{2}=[Fig7_intensity{2};peakI_afterDrug];

%% effect on mDia3

excelname='Fig4C 4D mDia3_Arp3_CK666';
experiment='mDia3_Arp3_ck_mDia3'; %use a shorter name to save all the plots
channel1 = readmatrix(excelname,'Sheet','Channel1');

[~,p2p_beforeDrug,p2p_afterDrug,...
    peakI_beforeDrug,peakI_afterDrug]=script_BatchProcess_IPI_v2(excelname,experiment,channel1);

%before
Fig7_p2p{11}=p2p_beforeDrug;
Fig7_intensity{11}=peakI_beforeDrug;

%after
Fig7_p2p{12}=p2p_afterDrug;
Fig7_intensity{12}=peakI_afterDrug;

%% save data

save('CK.mat','Fig7_p2p','Fig7_intensity');

%% master plot of everything
xx=10;
numbertoplot=1:xx;
[cb] = cbrewer2('qual','Set3',10,'pchip');
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*0.2 scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.6],'PaperPosition',[0.25 2.5 4 xx *0.8]);
for k=1:xx
    period=Fig7_p2p{numbertoplot(k)};

    if mod(k, 2) == 0  % Number is even, color is green
        subplot(xx,1,k), raincloud_plot(period, cb(1,:), [-10 100]);
    else
        subplot(xx,1,k), raincloud_plot(period, cb(9,:), [-10 100]);
    end
    if k<xx
        set(gca, 'XTickLabel', []);
        % axis off
    else
        xlabel('IPI (sec)');
    end
    box off

    s1=round(mean(period)*10)/10;
    s2=round(std(period)*10)/10;
    s3=length(period);
    stat_string=[num2str(s1) char(177) num2str(s2) ', n=' num2str(s3)];
    xL=xlim;yL=ylim;
    text(0.99*xL(2),0.99*yL(2),stat_string,'HorizontalAlignment','right','VerticalAlignment','top')
    hold on
end

print('-depsc','-r300', 'Fig7_IPI.eps');

%%
figure('Position',[scrsz(3)*0.2 scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.6],'PaperPosition',[0.25 2.5 4 xx*0.8]);

for k=1:xx
    Intensity_2=Fig7_intensity{numbertoplot(k)};
    Intensity=Intensity_2(:,1);
    if mod(k, 2) == 0  % Number is even, color is purple
        subplot(xx,1,k), raincloud_plot(Intensity, cb(3,:), [0 4]);%purple
    else
        subplot(xx,1,k), raincloud_plot(Intensity, cb(9,:), [0 4]);%gray
    end
    if k<xx
        set(gca, 'XTickLabel', []);
    else
        xlabel('Intensity');

    end
    box off

    s1=round(mean(Intensity)*10)/10;
    s2=round(std(Intensity)*10)/10;
    s3=length(Intensity);
    stat_string=[num2str(s1) char(177) num2str(s2) ', n=' num2str(s3)];
    xL=xlim;
    yL=ylim;
    text(0.99*xL(2),0.99*yL(2),stat_string,'HorizontalAlignment','right','VerticalAlignment','top')
    hold on
end

print('-depsc','-r300', 'Fig7_intensity.eps');










