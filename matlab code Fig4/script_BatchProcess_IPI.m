% updated 2024/3/23, script for calculating statistics of peak intensity, interpeak interval (Jerry paper)

[duration,cellnum] = size(channel1);

%% reset all as empty to start

p2p_bycell=[];
p2p_all_as_cell=[];
p2p_all_as_matrix=[];
peakI_bycell=[];
peakI_as_cell=[];
peakI_as_matrix=[];

%% analyze every single cell (column in the excel)


for k=1:cellnum

    disp(['cell#_' num2str(k)]);
    name = [experiment '_' num2str(k)];
    ROI_profile=channel1(:,k);

    [peak_distance,peak_amplitude]=OS_poincare_v5(ROI_profile,name,timeinterval(k));
    p2p_bycell(k,1)=mean(peak_distance);
    p2p_bycell(k,2)=std(peak_distance);
    p2p_all_as_cell{k}=peak_distance;
    p2p_all_as_matrix=[p2p_all_as_matrix; peak_distance];

    peakI_bycell(k,1)=mean(peak_amplitude);
    peakI_bycell(k,2)=std(peak_amplitude);
    peakI_as_cell{k}=peak_amplitude;
    peakI_as_matrix=[peakI_as_matrix; peak_amplitude];

    close all
end

%% RAINCLOUD PLOT

% get nice colours from color brewer
% (https://uk.mathworks.com/matlabcentral/fileexchange/34087-cbrewer---colorbrewer-schemes-for-matlab)


Folder1 = cd;
warning off MATLAB:MKDIR:DirectoryExists
warning('off', 'Images:initSize:adjustingMag');
warning('off', 'MATLAB:xlswrite:AddSheet');

mkdir([Folder1 '/0histogram']);
mkdir([Folder1 '/0raincloud']);
mkdir([Folder1 '/0raincloud_mat']);



%% compile all the p2p (interpeak intervals) from different cell in one histogram

scrsz = get(0,'ScreenSize');
[cb] = cbrewer2('qual','Set3',10,'pchip');
figure('Position',[scrsz(3)*0.2 scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.2],'PaperPosition',[0.25 2.5 5 2]);
raincloud_plot(p2p_all_as_matrix, cb(1,:), [-20 100]); % color is turquoise
xlabel('IPI (sec)');
s1=round(mean(p2p_all_as_matrix)*10)/10;
s2=round(std(p2p_all_as_matrix)*10)/10;
s3=length(p2p_all_as_matrix);
stat_string=[num2str(s1) char(177) num2str(s2) ', n=' num2str(s3)];
xL=xlim;
yL=ylim;
text(0.99*xL(2),0.99*yL(2),stat_string,'HorizontalAlignment','right','VerticalAlignment','top')

cd([Folder1 '/0raincloud']);
print('-depsc','-r300', [experiment '_p2p_raincloud_.eps']);
cd('..');

%% separate individual cell (every 10 cells, plot one figure, to check single cell data)
m=ceil(cellnum/10);
for p=1:m
    figure('Position',[scrsz(3)*0.2*p scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.6],'PaperPosition',[0.25 2.5 5 10]);
    firstcell=(p-1)*10+1;
    lastcell=min(p*10, cellnum);
    plotnumber=lastcell-firstcell+1;

    for k=firstcell:lastcell
        peak_distance=p2p_all_as_cell{k};
        if ~isempty(peak_distance)
            subplot(10,1, k-firstcell+1), raincloud_plot(peak_distance, cb(k-firstcell+1,:), [-20 100]);
            stat_string=['n=' num2str(length(peak_distance))];
            xL=xlim;
            yL=ylim;
            text(0.99*xL(2),0.99*yL(2),stat_string,'HorizontalAlignment','right','VerticalAlignment','top')
        end
    end
    xlabel('IPI (sec)');
    cd([Folder1 '/0raincloud']);
    print('-depsc','-r300', [experiment '_p2p_raincloud_' num2str(p) '.eps']);
    cd('..');

end

%% raincloud for peak intensity (combined to a single plot) % not meaningful if data is not normalized
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*0.2 scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.2],'PaperPosition',[0.25 2.5 5 2]);
raincloud_plot(peakI_as_matrix, cb(10,:), [0 4]); % intensity plot with purple color
xlabel('Intensity');

s1=round(mean(peakI_as_matrix)*10)/10;
s2=round(std(peakI_as_matrix)*10)/10;
s3=length(peakI_as_matrix);
stat_string=[num2str(s1) char(177) num2str(s2) ', n=' num2str(s3)];
xL=xlim;
yL=ylim;
text(0.99*xL(2),0.99*yL(2),stat_string,'HorizontalAlignment','right','VerticalAlignment','top')

cd([Folder1 '/0raincloud']);
print('-depsc','-r300', [experiment '_peakN_raincloud_.eps']);
cd('..');

%% raincloud for peak intensity (individual cell)
for p=1:m
    figure('Position',[scrsz(3)*0.2*p scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.6],'PaperPosition',[0.25 2.5 5 10]);
    firstcell=(p-1)*10+1;
    lastcell=min(p*10, cellnum);
    plotnumber=lastcell-firstcell+1;

    for k=firstcell:lastcell
        peak_amplitude=peakI_as_cell{k};
        if ~isempty(peak_amplitude)

            subplot(10,1, k-firstcell+1), raincloud_plot(peak_amplitude, cb(k-firstcell+1,:));
            %subplot(plotnumber,1, k-firstcell+1), raincloud_plot(peak_amplitude, cb(k-firstcell+1,:),[0 400]); % not meaningful to force the same scale
            stat_string=['n=' num2str(length(peak_amplitude))];
            xL=xlim;
            yL=ylim;
            text(0.99*xL(2),0.99*yL(2),stat_string,'HorizontalAlignment','right','VerticalAlignment','top')
        end
    end
    xlabel('Intensity');
    cd([Folder1 '/0raincloud']);
    print('-depsc','-r300', [experiment '_peakN_raincloud_' num2str(p) '.eps']);
    cd('..');

end

%% save data

disp(experiment);
tf = p2p_bycell(:,1) < 50 ;
p2p_bycell_mean=[nanmean(p2p_bycell(:,1))  nanmean(p2p_bycell(tf,1))];
p2p_bycell_sem=[nanstd(p2p_bycell(:,1)) nanstd(p2p_bycell(tf,1))];
peakI_bycell_mean=nanmean(peakI_bycell(:,1));
peakI_bycell_sem=nanstd(peakI_bycell(:,1));
cd([Folder1 '/0raincloud_mat']);
save([experiment '_peaks.mat'],'cellnum','p2p_bycell','p2p_bycell_mean','p2p_bycell_sem','p2p_all_as_cell','p2p_all_as_matrix',...
    'peakI_bycell','peakI_bycell_mean','peakI_bycell_sem','peakI_as_cell','peakI_as_matrix');
save([experiment '_peaks_all.mat'],'p2p_all_as_matrix','peakI_as_matrix');
cd('..');
