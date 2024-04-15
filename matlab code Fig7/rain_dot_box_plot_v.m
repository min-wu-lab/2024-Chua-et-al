%% updated 2024/3/26 mw

%%
% rain_dot_box_plot_v is plot vertical bars
% rain_dot_box_plot is plot horizontal bars

%% raincloud_plot - plots a combination of half-violin, boxplot,  and raw
% datapoints (1d scatter).
% Use as h = raincloud_plot(X, cl), where X is a data vector and cl is an
% RGB value. h is a cell array of handles for the various figure parts.
% Based on https://micahallen.org/2018/03/15/introducing-raincloud-plots/
% Inspired by https://m.xkcd.com/1967/

function h = rain_dot_box_plot_v(X, cl, varargin)

%  specify plot size (y)
if nargin>=3
    YaxisLim=varargin{1};
    set(gca, 'YLim', YaxisLim);
end

%  specify plot size (x center)
center = 0.5; % default is 0.5; plot x limit is from 0:1
if nargin>=4
    center = varargin{2};
end

% width of boxplot
wdth = 0.5;

% jitter for raindrops
jit = (rand(size(X)) -0.5) * wdth +center;

% raindrops (h{1} is missing: in the raincloud_plot.m, h{1} is for the cloud
h{2} = scatter(jit, X);
h{2}.SizeData = 2; % 4 or 6
h{2}.MarkerFaceColor = cl;
h{2}.MarkerEdgeColor = 'none';

% info for making boxplot
Y = quantile(X, [0.25 0.75 0.5 0.02 0.98]);

% 'box' of 'boxplot'
h{3} = rectangle('Position', [ center-0.25 Y(1)  0.5 Y(2)-Y(1)]);
set(h{3}, 'EdgeColor', 'k')
set(h{3}, 'LineWidth', 0.4);

% mean line
h{4} = line( [center-0.25 center+0.25],[Y(3) Y(3)], 'col', 'k', 'LineWidth', 1);

% whiskers
h{5} = line( [center center], [Y(2) Y(5)],'col', 'k', 'LineWidth', 0.4);
h{6} = line( [center center], [Y(1) Y(4)],'col', 'k', 'LineWidth', 0.4);

%set(gca,'XTick',nan);
%set(gca, 'XLim', [0 1]);

