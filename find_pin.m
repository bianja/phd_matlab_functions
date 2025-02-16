function [pin_times] = find_pin(ch_times, ch_values, th)

% INPUT
% ch_times = time axis of pin channel 
% ch_values = y axis information of pin values
% th = threshold to cross for single pins
%
% OUTPUT
% pin_times = contains time values of pins
%
% EXAMPLE
% find_pin(Ch1.times, Ch1.values, -0.015)
%
% Version 05-12-2022
 
stim_times_all = ch_times(find(ch_values < th)); %#ok<FNDSB>


j = 1;
for k = 1 : length(stim_times_all) - 1
    if stim_times_all(k+1) > stim_times_all(k)+0.5
        pin_times(j+1) = stim_times_all(k+1); %#ok<AGROW>
        j = j + 1;
    end
end
pin_times(1) = stim_times_all(1);

    
    