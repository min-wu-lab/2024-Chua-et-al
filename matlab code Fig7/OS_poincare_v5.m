function [peak_distance,OS_peak]=OS_poincare_v5(ROI_profile,name,timeinterval,varargin)

% last updated 20240324 mw. 
% Diffrence from V4, normalize data first, then find peaks. Deleted unused codes

%% This code is for analyzing traces with irregular periodicity, including

%% load the traces 

ROI_profile=ROI_profile(~isnan(ROI_profile));
ROI_profile=double(ROI_profile);
ll=length(ROI_profile);
timeaxis=(0:timeinterval:(ll-1)*timeinterval)/60;

%% define common variable

LineW=0.4;
radius = round(10/timeinterval); % this parameter is used to define peaks. If 6, means peak needs to be greater than its +/- 6 neighbours
if nargin==5
    cutoff=varargin{1};
else
    cutoff=1.15; 
end
background=100;

colorofcurve='k';
scrsz = get(0,'ScreenSize');

%% make new folder to save plots 

Folder1 = cd;
warning off MATLAB:MKDIR:DirectoryExists
warning('off', 'Images:initSize:adjustingMag');
mkdir([Folder1 '/0analysis']);

%% find peaks (use raw trace, defined as greater than its +/- 6 neighbours, or as defined by "radius")
allpeaks = zeros(ll-radius);
for iii=1:ll-radius
    product=1;
    for jjj=1:radius*2+1
        product=product*(ROI_profile(iii)>=ROI_profile(max(1, (iii-radius-1+jjj))));
    end
    allpeaks(iii)=product;
end

allpeaksindex=find (allpeaks==1);

%% use an threshold of intensity to remove small peaks
new=sort(ROI_profile);
baseline=mean(new(1:50)); % define baseline as the average of lowest 50 points

ROI_profile=(ROI_profile-background)/(baseline-background);
hh= ROI_profile(allpeaksindex)>cutoff;
allpeaksindex=allpeaksindex(hh);

%% plot curve with + sign and all peak/valley highlighted to visually verify the accuracy

figure('Position',[scrsz(3)*0.3 scrsz(4)*0.8 scrsz(3)*0.6 scrsz(4)*0.2],'PaperPosition',[1 12 12 1]);
plot(timeaxis,ROI_profile,'+-','Color',colorofcurve,'MarkerSize',4,'LineWidth',LineW/2);
hold on;
ax1 = gca;

% highlight all the peaks w filled dot
plot(timeaxis(allpeaksindex),ROI_profile(allpeaksindex),'m.', 'MarkerSize',10,'Parent',ax1);
hold on;

cd([Folder1 '/0analysis']);

set(gca,'XLim',[0 40]);
print('-depsc','-r300', [name '_peak_' num2str(cutoff) '_40.eps']);

cd('..');

%% Once veried, establish a new series that is just all the peaks.

OS_peak=ROI_profile(allpeaksindex);
peak_distance = diff(allpeaksindex)*timeinterval;


