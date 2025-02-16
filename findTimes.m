function [startval,endval] = findTimes(times,values,th,rep,diffVal,len)
% th = -0.015;
% times = Ch10.times;



stim_times_all = times(values < th); % 10 for other recordings 0.17
% stim_times_temp = zeros(120*rep*2,1);
stim_first = stim_times_all(1);
stim_last = 0;

times_start = zeros(len,1);
times_end = zeros(len,1);
for i = 1 : rep
    temp = stim_times_all(find(stim_times_all > stim_last));
    stim_first = temp(1);  
    times_start(:,i) = stim_first : diffVal : stim_first+len*diffVal-1;
    times_end(:,i) = stim_first+5 : diffVal : stim_first+5+len*diffVal-1;
%     times_start(:,i) = stim_first : 20 : stim_first+120*20-1; % for A50
%     times_end(:,i) = stim_first+10 : 20 : stim_first+10+120*20-1;
    stim_last = times_end(end,i)+10;
end

startval = zeros(rep*len,1);
endval = zeros(rep*len,1);
for i = 1 : rep
    startval(i*len-len+1 : i*len) = times_start(:,i);
    endval(i*len-len+1 : i*len) = times_end(:,i);
end
