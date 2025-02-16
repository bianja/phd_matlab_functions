function [spikes] = calcSpikes(times)


% times = Ch.times;
% stimstart = times(4);
% stimend = times(5);
% turns = 1;


vel = times(find(times > stimstart & times < stimend)); %#ok<FNDSB>
vel = vel - stimstart;
spikes = vel * (360 * turns) / (stimend - stimstart);
spikes = reset360(spikes);
