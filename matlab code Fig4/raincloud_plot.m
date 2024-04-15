%% updated 2024/2/22
% 
% 2024/2/15 mw, change xLim to be fixed or varargin
% 2024/2/22 mw, remove Y tick label

%% raincloud_plot - plots a combination of half-violin, boxplot,  and raw
% datapoints (1d scatter).
% Use as h = raincloud_plot(X, cl), where X is a data vector and cl is an
% RGB value. h is a cell array of handles for the various figure parts.
% Based on https://micahallen.org/2018/03/15/introducing-raincloud-plots/
% Inspired by https://m.xkcd.com/1967/
% Thanks to Jacob Bellmund for some improvements

function h = raincloud_plot(X, cl, varargin)

% calculate kernel density
[f, Xi] = ksdensity(X);

% density plot
h{1} = area(Xi, f); hold on
set(h{1}, 'FaceColor', cl);
set(h{1}, 'EdgeColor', [0.1 0.1 0.1]);
set(h{1}, 'LineWidth', 0.4);

% make some space under the density plot for the boxplot
yl = get(gca, 'YLim');
set(gca, 'YLim', [-yl(2) yl(2)]);
set(gca,'YTick',nan);
if nargin==3
    XaxisLim=varargin{1};
    set(gca, 'XLim', XaxisLim);
end

% width of boxplot
wdth = yl(2)*0.5;

% jitter for raindrops
jit = (rand(size(X)) - 0.5) * wdth;

% info for making boxplot
Y = quantile(X, [0.25 0.75 0.5 0.02 0.98]);

% raindrops
h{2} = scatter(X, jit - yl(2)/2);
h{2}.SizeData = 6;
h{2}.MarkerFaceColor = cl;
h{2}.MarkerEdgeColor = 'none';

% 'box' of 'boxplot'
h{3} = rectangle('Position', [Y(1) -yl(2)/2-(wdth*0.5) Y(2)-Y(1) wdth]);
set(h{3}, 'EdgeColor', 'k')
set(h{3}, 'LineWidth', 0.4);
% could also set 'FaceColor' here as Micah does, but I prefer without

% mean line
h{4} = line([Y(3) Y(3)], [-yl(2)/2-(wdth*0.5) -yl(2)/2+(wdth*0.5)], 'col', 'k', 'LineWidth', 1);

% whiskers
h{5} = line([Y(2) Y(5)], [-yl(2)/2 -yl(2)/2], 'col', 'k', 'LineWidth', 0.4);
h{6} = line([Y(1) Y(4)], [-yl(2)/2 -yl(2)/2], 'col', 'k', 'LineWidth', 0.4);

