function [startval,endval] = findTimesCorrected(times,values,th,rep,diffStim,diffPause,len)
% th = -0.015;
% times = Ch10.times;



stim_times_all = times(values < th); % 10 for other recordings 0.17
% stim_times_temp = zeros(120*rep*2,1);
stim_first = stim_times_all(1);
stim_last = 0;

times_all = zeros(len*2*rep,1);
temp = stim_times_all(find(stim_times_all > stim_last));
stim_first = temp(1);
% times_all(1) = stim_first;
k = 1;
for j = 2 : length(temp)-1
    if round(temp(j+1)) > round(temp(j))+1 % peak
        times_all(k) = temp(j);
        k = k + 1;
    end
end

if isempty(find(round(diff(times_all))>30))
    endval = [1; find(round(diff(times_all))==15)+1; length(times_all)];
%     endval = [1; find(round(diff(times_all))>15 && round(diff(times_all))<30)+1; length(times_all)];
else
    endval = [1; find(round(diff(times_all))>30)+1; length(times_all)];
end

for i = 1 : rep
    times_start{i} = times_all(endval(i):2:endval(i+1)-1);
    times_end{i} = times_all(endval(i)+1:2:endval(i+1));
    corrStart{i} = find(round(diff(times_start{1, 1})) ~= 15);
    corrEnd{i} = find(round(diff(times_end{1, 1})) ~= 15);
end

% add missing stim to start times vector
for j = 1 : rep
    missadd = find(round(diff(times_start{j})) ~= 15)+1;
    if length(missadd) > 4
        addval = 4;
    else 
        addval = length(missadd);
    end
    missVal = [1; missadd(1:addval); length(times_start{j})]; % startvalues (except last value which gives last value)
    for i = 2 : len-length(times_start{j})+1
        gap = round((times_start{j}(missVal(i)))-(times_start{j}(missVal(i)-1)))/15;
        if gap > 2
            add(1) = missVal(i);
            for k = 2 : gap-1
                add(k) = add(k-1)+1;
            end
            missVal = [missVal(1:i-1);add';missVal(i+1:end)];
        end
    end
    diffVal = median(diff(times_start{j})); % value which needs to be added to startvalue
    t = [];
    for i = 1 : length(missVal)-2
        newVal(i) = times_start{j}(missVal(i+1)-1)+diffVal; % these are the time values which needs to be added at NaN positions
        t = [t; times_start{j}(missVal(i):missVal(i+1)-1); newVal(i)]; % startvalue is okay; endvalue is at position i+1 (which is startvalue of next rep), hence additional +1 to go one line further
        if i == (length(missVal)-2) % to add last part of time vector after last NaN
            t = [t; times_start{j}(missVal(end-1):missVal(end))];
        end
    end
    if length(t) == len-1 % first stim was 120 8
        t = [t(1)-diffVal; t];
    end
    times_start{j} = t;
    times_start{j} = times_start{j}(1:len);
end

% add missing stim to end times vector
for j = 1 : rep
    missadd = find(round(diff(times_end{j})) ~= 15)+1;    
    if length(missadd) > 4
        addval = 4;
    else 
        addval = length(missadd);
    end
    missVal = [1; missadd(1:addval); length(times_end{j})]; % startvalues (except last value which gives last value)
    for i = 2 : len-length(times_end{j})+1
        gap = round((times_end{j}(missVal(i)))-(times_end{j}(missVal(i)-1)))/15;
        if gap > 2
            add(1) = missVal(i);
            for k = 2 : gap-1
                add(k) = add(k-1)+1;
            end  
            missVal = [missVal(1:i-1);add';missVal(i+1:end)];
        end
    end
    diffVal = median(diff(times_end{j})); % value which needs to be added to startvalue
    t = [];
    for i = 1 : length(missVal)-2
        newVal(i) = times_end{j}(missVal(i+1)-1)+diffVal; % these are the time values which needs to be added at NaN positions
        t = [t; times_end{j}(missVal(i):missVal(i+1)-1); newVal(i)]; % startvalue is okay; endvalue is at position i+1 (which is startvalue of next rep), hence additional +1 to go one line further
        if i == (length(missVal)-2) % to add last part of time vector after last NaN
            t = [t; times_end{j}(missVal(end-1):missVal(end))];
        end
    end
    if length(t) == len-1 % first stim was 120 8
        t = [t(1)-diffVal; t];
    end
    times_end{j} = t;
    times_end{j} = times_end{j}(1:len);
end

% save to output variables
startval = zeros(rep*len,1);
endval = zeros(rep*len,1);
for i = 1 : rep
    startval(i*len-len+1 : i*len) = times_start{i};
    endval(i*len-len+1 : i*len) = times_end{i};
end
