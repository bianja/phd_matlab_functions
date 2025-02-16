function [background, backgroundRaw, spikes, exclude] = testData(start, endval, data, rep, len)

% this functions tests for odd changes in spiking
% What counts as odd? Changes in baseline: Calculate basline in between
% stimuli and compare to each other
% exclude provides positions which should get excluded cause background
% activity is out of range of mean+-sd for at least two background activity
% bins (meaning one before and one after the corresponding response to
% stimulation)

% extract spikes between end and start of stimuli and calculate spikes/s in gaps
spikes = zeros(1,len*rep);
for i = 1 : len*rep - 1
    spikes(i) = (sum((data.times > (endval(i)+7) & data.times < start(i+1)) == 1))/(start(i+1)-(endval(i)+7));
end

% calculate baseline activity
% prctile(var,0.05);
background(1) = nanmean(spikes);
background(2) = nanstd(spikes);
% background(1) = nanmedian(spikes);
% background(2) = prctile(spikes,45);
% background(3) = prctile(spikes,100);
backgroundRaw = spikes;


% find outlier spike activity to exclude corresponding stimulus responses
% outlier = find(spikes < background(1)-background(2) | spikes > background(1)+background(2) | spikes == 0);
% outlier_shift = [0 outlier]+1;
% outlier = [outlier 0];
% exclude = outlier(outlier-outlier_shift == 0)+1;
exclude = [];

% plot over time
% figure
% plot(spikes,'k')
% line([0 120*rep],[background(1)-background(2) background(1)-background(2)],'LineWidth',1.5,'Color','k')
% line([0 120*rep],[background(1)+background(3) background(1)+background(3)],'LineWidth',1.5,'Color','k')
% line([0 120*rep],[background(1) background(1)],'LineWidth',1.5,'Color',[0.5 0.5 0.5])




