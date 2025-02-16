function [rec] = find_spikes_RF(T,unit,rec,firstUnit,numUnit)
% this function is to find all spikes for all stimuli to define receptive
% fields. Basically, T contains the spike data and rec the stimuli which
% were presented. In the end rec gives the input erc file but additionally
% a further colum 'spikes' containing all spikes (related to 360 ° of 
% arena/time) for this particular stimulus 


% T = data-mat-file containing the channel information (file which is
% extracted from Spike2)
% unit = which unit number? 1 = first unit which is usually channel 17 of
% my tetrode recordings
% rec = rec-mat-file provided by the user interface to show the single
% stripe stimulus

% example
% find_spikes_RF(T01,AllAni(1).UnitNbr,S{1,1}.rec);

%% ask for first spike channel (for normal receptive field script)
% c = 1; spikeChannels = [];
% names = fieldnames(T);
% n = size(struct2table(T),2);
% vars = cell(n,1);
% for i = 1 : n
%     vars(i) = names(i);
% end
% 
% spikeChannels = firstUnit+1 : firstUnit+numUnit;

%% use this to find channels for add_table
c = 1; 
names = fieldnames(T);
n = size(struct2table(T),2);
vars = cell(n,1);
for i = 1 : n
    vars(i) = names(i);
end
for i = 1 : size(vars,1)
    if ~contains((char(vars(i))),'file')
        chName{i} = T.(char(vars(i))).title;
    end
end
chSpike = vars(contains(chName,'nw') & contains(chName,'0'));

for i = 1 : length(chSpike)
    spikeChannels(i) = str2num(chSpike{i}(3:4));
end




% for i = 1 : length(vars)
%     if length(vars{i}) == 4 && isempty(str2num(vars{i}(3))) == 0 && isempty(str2num(vars{i}(4))) == 0 && str2num([(vars{i}(3)) (vars{i}(4))]) > 14 % having a number and channel higher 14
%         spikeChannels(c) = str2num([(vars{i}(3)) (vars{i}(4))]);
%         c = c + 1;
%     else
%     end
% end

% to analyse information of single units -> remove first channel value as
% this is all units spiking information
% switch combined
%     case 'yes'
%         spikeChannels = spikeChannels(spikeChannels~=spikeChannels(1));
%     case 'no'
%     otherwise
%         error('define if combined unit channel is extracted')
% end

%% find pins to find time points of stimuli
if exist('Ch1')
    stim = findTimes_ReceptiveField(T.Ch1.times, T.Ch1.values, -0.015, rec); % either Ch1 or Ch14
else
    stim = findTimes_ReceptiveField(T.Ch1.times, T.Ch1.values, -0.015, rec); % either Ch1 or Ch14
end

%% find spike values
for j = 1 : size(stim,1)
    for k = 1 : size(stim,2)-1
        temp = find(T.(['Ch',num2str(spikeChannels(unit))]).times > stim(j,k) & T.(['Ch',num2str(spikeChannels(unit))]).times < stim(j,k+1));
        stim_time(k) = stim(j,k+1)-stim(j,k);
        spike_rate(j,k) = length(temp);%-baseline(1);
        spikes{j,k} = T.(['Ch',num2str(spikeChannels(unit))]).times(temp);
        clear temp
    end
    spike_rate_temp(j,:) = spike_rate(j,:);
    spike_rate(j,:) = spike_rate(j,:)/mean(stim_time);
    
    %% find bg activity
    tempBG = find(T.(['Ch',num2str(spikeChannels(unit))]).times > stim(j,1)-2 & T.(['Ch',num2str(spikeChannels(unit))]).times < stim(j,1));
    bg(j) = length(tempBG)/2;
end

%% find spikes for all stimuli and write them in table
% names = {'test1','test2'};
for s = 1 : size(stim,1)
    tAll = [];
    for r = 1 : 5
        emptcount = 0;
        t = (spikes{s,r}-stim(s,r))*360/diff(stim(s,r:r+1));
        if rec(s).vel < 0
%             t = 360-t;
            %         t = t/360*2*pi;
        else
        end
        tAll = [tAll; t];
    end
    if isempty(tAll) == 1 % true
        rec(s).spikes = NaN;
        rec(s).bg = bg(s);
    else
        rec(s).spikes = tAll;
        rec(s).bg = bg(s);
    end
end
