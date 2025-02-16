function [peaks] = findStepsPOL(INtimes, INvalues, th, starttime)

% function to identify movement velocity
%
% INPUT: POL steps, Ch16
% INtimes = steps channel times (x-axis)
% INvalues = steps channel values (y-axis)
% th = drop at least by th on either side before signal attains a higher value
% starttime = start time to search for steps
%
% OUTPUT
% times = contains peak times (times at which stimuli start)
%
% EXAMPLE
% findStepsPOL(Ch16.times, Ch16.values, 0.003, 5)


% find peaks
b = (find(INtimes > starttime,1));
[~, loc] = findpeaks(INvalues(b:end),'MinPeakProminence',th,'MinPeakHeight',-0.06);
temp = INtimes(b:end);
peaks = temp(loc);