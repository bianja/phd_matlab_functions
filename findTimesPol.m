function [times] = findTimesPol(INtimes, INvalues, th, starttime)

% INPUT: stimpulse Ch15
% INtimes = Ch15.times; stimpulse channel times (x-axis)
% INvalues = Ch15.values; stimpulse channel values (y-axis)
% th = 0.002; y-axis th, which needs to be crossed for finding stimpulses
% starttime = 5; start time to search for stimpulses
%
% OUTPUT
% times = contains peak times (times at which stimuli start)


% find peaks
b = (find(INtimes > starttime,1));
[~, loc] = findpeaks(INvalues(b:end),'MinPeakHeight',th);
INtimes = INtimes(b:end);
times = INtimes(loc);

% for P11: reset 0-axis (one stimpulse), CW dir (22 stimpulse), CCW dir (22
% stimpulse)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot data to control for correct peaks
% figure
% plot(INtimes, INvalues(b:end))
% hold on
% plot(times,zeros(1,length(times))+0.005,'xr')