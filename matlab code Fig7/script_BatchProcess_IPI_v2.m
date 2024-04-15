
% updated 2024/3/23, function for calculating statistics of peak intensity, interpeak interval (Jerry paper)

% script_BatchProcess_IPI_v2.m is for data with drug, so add a new variable
% "peak_class" to indicate
% 1: before drug;
% 2: after drug;
% 3: not the above.

function [cellnum,p2p_beforeDrug,p2p_afterDrug,...
    peakI_beforeDrug,peakI_afterDrug]=script_BatchProcess_IPI_v2(excelname,experiment,channel1)

timeinterval=readmatrix(excelname,'Sheet','time interval');
firstaddsth=readmatrix(excelname,'Sheet','drugadd(f)');
drugconcentration=readmatrix(excelname,'Sheet','concentration');

[~,cellnum] = size(channel1);
peak_distance_histogram_upperlimit=50;

%% reset all as empty to start

p2p_all_as_cell=[];
p2p_beforeDrug=[];
p2p_afterDrug=[];

peakI_as_cell=[];
peakI_beforeDrug=[];
peakI_before_Norm=[];
peakI_afterDrug=[];
peakI_after_Norm=[];

%% analyze every single cell (column in the excel)

for k=1:cellnum

    disp(['cell#_' num2str(k)]);
    name = [experiment '_' num2str(k)];
    ROI_profile=channel1(:,k);

    [peak_distance,peak_amplitude,peaksindex]=OS_poincare_v5(ROI_profile,name,timeinterval(k),peak_distance_histogram_upperlimit,1.05);

    drug_f=firstaddsth(~isnan(firstaddsth(:,k)),k);
    drug_conc=drugconcentration(~isnan(drugconcentration(:,k)),k);
    peak_class=[];
    peak_class(peaksindex<(drug_f (1)+1) & drug_conc(1)==50)=1;
    if length(drug_f)==1
        peak_class(peaksindex>drug_f  & drug_conc(1)==50)=2;
        if length(drug_f)>1
            peak_class(peaksindex>drug_f(1) & peaksindex<(drug_f (2)+1) & drug_conc(1)==50)=2;
        end
    end
    peak_class(drug_conc(1)>50)=3; %if first drug >50, do not quantify
    peak_class(length(peak_class))=[]; %because peak_distance has one less number, remove the last number

    p2p_all_as_cell{k}=peak_distance;
    p2p_beforeDrug=[p2p_beforeDrug; peak_distance(peak_class==1)];
    p2p_afterDrug=[p2p_afterDrug; peak_distance(peak_class==2)];


    peakI_as_cell{k}=peak_amplitude;
    average_beforeDrug=mean(peak_amplitude(peak_class==1))-1;

    peakI_beforeDrug=[peakI_beforeDrug; peak_amplitude(peak_class==1)];
    peakI_before_Norm=[peakI_before_Norm; (peak_amplitude(peak_class==1)-1)/average_beforeDrug];
    peakI_afterDrug=[peakI_afterDrug; peak_amplitude(peak_class==2)];
    peakI_after_Norm=[peakI_after_Norm; (peak_amplitude(peak_class==2)-1)/average_beforeDrug];

    close all
end

% this is to combine the two series (normalized or not) into one variable
% so we don't have to change the function output (the normalized version was added
% later)
peakI_beforeDrug=[peakI_beforeDrug peakI_before_Norm];
peakI_afterDrug=[peakI_afterDrug peakI_after_Norm];

%% RAINCLOUD PLOT

% get nice colours from color brewer
% (https://uk.mathworks.com/matlabcentral/fileexchange/34087-cbrewer---colorbrewer-schemes-for-matlab)


Folder1 = cd;
warning off MATLAB:MKDIR:DirectoryExists
warning('off', 'Images:initSize:adjustingMag');
warning('off', 'MATLAB:xlswrite:AddSheet');

mkdir([Folder1 '/0raincloud']);
mkdir([Folder1 '/0raincloud_mat_b_a']);

%% save data

disp(experiment);
cd([Folder1 '/0raincloud_mat_b_a']);
save([experiment '_peaks_b_a.mat'],'cellnum','p2p_beforeDrug','p2p_afterDrug',...
    'peakI_beforeDrug','peakI_afterDrug');
cd('..');

%% compile all the p2p (interpeak intervals) from different cells in one histogram

scrsz = get(0,'ScreenSize');
[cb] = cbrewer2('qual','Set3',10,'pchip');
figure('Position',[scrsz(3)*0.2 scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.6],'PaperPosition',[0.25 2.5 5 4]);
subplot(2,1,1),    raincloud_plot(p2p_beforeDrug, cb(9,:), [-20 100]); % color is turquoise
set(gca, 'XTickLabel', []);
s1=round(mean(p2p_beforeDrug)*10)/10;
s2=round(std(p2p_beforeDrug)*10)/10;
s3=length(p2p_beforeDrug);
stat_string=[num2str(s1) char(177) num2str(s2) ', n=' num2str(s3)];

xL=xlim;
yL=ylim;
text(0.99*xL(2),0.99*yL(2),stat_string,'HorizontalAlignment','right','VerticalAlignment','top')

subplot(2,1,2),    raincloud_plot(p2p_afterDrug, cb(1,:), [-20 100]); % color is turquoise
xlabel('IPI (sec)');
s1=round(mean(p2p_afterDrug)*10)/10;
s2=round(std(p2p_afterDrug)*10)/10;
s3=length(p2p_afterDrug);
stat_string=[num2str(s1) char(177) num2str(s2) ', n=' num2str(s3)];

xL=xlim;
yL=ylim;
text(0.99*xL(2),0.99*yL(2),stat_string,'HorizontalAlignment','right','VerticalAlignment','top')

cd([Folder1 '/0raincloud_mat_b_a']);
print('-depsc','-r300', [experiment '_p2p_b_a_.eps']);
cd('..');

%% raincloud for peak intensity (combined to a single plot) % not meaningful if data is not normalized
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*0.2 scrsz(4)*0.8 scrsz(3)*0.2 scrsz(4)*0.2],'PaperPosition',[0.25 2.5 5 4]);
for m=1:4
    subplot(4,1,m),
    if m==1
        intensity=peakI_beforeDrug(:,1);plot_color=cb(9,:);
    elseif m==2
        intensity=peakI_afterDrug(:,1);plot_color=cb(1,:);
    elseif m==3
        intensity=peakI_beforeDrug(:,2);plot_color=cb(9,:);
    else
        intensity=peakI_afterDrug(:,2);plot_color=cb(1,:);
    end
    raincloud_plot(intensity, plot_color, [0 4]); % color is turquoise

    box off
    s1=round(mean(intensity)*10)/10;
    s2=round(std(intensity)*10)/10;
    s3=length(intensity);
    stat_string=[num2str(s1) char(177) num2str(s2) ', n=' num2str(s3)];

    xL=xlim;
    yL=ylim;
    text(0.99*xL(2),0.99*yL(2),stat_string,'HorizontalAlignment','right','VerticalAlignment','top')

    if m<4
        set(gca, 'XTickLabel', []);
    else
        xlabel('Intensity');
    end

end

cd([Folder1 '/0raincloud_mat_b_a']);
print('-depsc','-r300', [experiment '_peakI_b_a_.eps']);
cd('..');


