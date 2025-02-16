function [stim] = findTimes_ReceptiveField(times,values,th,rec)
% th = -0.015;
% times = Ch10.times;



stim_times_all = times(values < th); 
stim_first = stim_times_all(1);
stim_last = 0;

times_start = zeros(size(rec,2)*6,1);
times_end = zeros(size(rec,2)*6,1);

times_start(1) = stim_first;
c = 2;
for i = 1 : size(stim_times_all,1)-1
    if stim_times_all(i+1) > stim_times_all(i)+0.1
        times_start(c) = stim_times_all(i+1);
        c = c + 1;
    end
end


c = 1;
for i = 1 : size(rec,2)
    for j = 1 : 6
        stim(i,j) = times_start(c);
        c = c + 1;
    end
end




% for i = 1 : size(rec,2)
%     temp = stim_times_all(find(stim_times_all > stim_last));
%     stim_first = temp(1);  
%     times_start(:,i) = stim_first : 15 : stim_first+30*15-1;
%     times_end(:,i) = stim_first+5 : 15 : stim_first+30*15-1;
%     stim_last = times_end(end,i)+10;
% end
% 
% startval = zeros(size(rec,2),1);
% endval = zeros(size(rec,2),1);
% for i = 1 : size(rec,2)
%     startval(i*120-120+1 : i*120) = times_start(:,i);
%     endval(i*120-120+1 : i*120) = times_end(:,i);
% end