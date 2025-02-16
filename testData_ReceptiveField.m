function [background, spikes, exclude] = testData_ReceptiveField(start, endval, data, rec)

% this functions tests for odd changes in spiking
% What counts as odd? Changes in baseline: Calculate basline in between
% stimuli and compare to each other
% exclude provides positions which should get excluded cause background
% activity is out of range of mean+-sd for at least two background activity
% bins (meaning one before and one after the corresponding response to
% stimulation)

% extract spikes between end and start of stimuli and calculate spikes/s in gaps
spikes = zeros(1,size(rec,2)-1);
for i = 1 : size(rec,2) - 1
    dif = start(i+1)-endval(i);
    spikes(i) = (sum((data.times > start(i+1)-0.5 & data.times < start(i+1)) == 1))*2;
end
% spikes = (sum((data.times > 0 & data.times < start(1)) == 1))/(start(1) - 0);


% calculate baseline activity
% prctile(var,0.05);
background(1) = nanmean(spikes);
background(2) = nanstd(spikes);
% background(2) = prctile(spikes,45);
% background(3) = prctile(spikes,100);

% find outlier spike activity to exclude corresponding stimulus responses
% outlier = find(spikes < background(1)-background(2) | spikes > background(1)+background(2) | spikes == 0);
% outlier_shift = [0 outlier]+1;
% outlier = [outlier 0];
% exclude = outlier(outlier-outlier_shift == 0)+1;
exclude = [];
