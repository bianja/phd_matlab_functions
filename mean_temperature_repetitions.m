function [meanData] = mean_temperature_repetitions(table)
%
% INPUT
% table = all R0X data for median values (each row = one R)
%
% OUTPUT
% meanData = mean values of all input data

width = [2 4 8];
for i = 1 : size(table,2)
    for j = 1 : 3 % stripe width
        % yfreq mean
        meanbw.(['w',num2str(width(j))])(i,:) = table(i).yfreq.mean.translation.bw.(['w',num2str(width(j))]);
        meanfw.(['w',num2str(width(j))])(i,:) = table(i).yfreq.mean.translation.fw.(['w',num2str(width(j))]);
        meancw.(['w',num2str(width(j))])(i,:) = table(i).yfreq.mean.rotation.cw.(['w',num2str(width(j))]);
        meanccw.(['w',num2str(width(j))])(i,:) = table(i).yfreq.mean.rotation.ccw.(['w',num2str(width(j))]);
        % yfreq sd
        sdbw.(['w',num2str(width(j))])(i,:) = table(i).yfreq.sd.translation.bw.(['w',num2str(width(j))]);
        sdfw.(['w',num2str(width(j))])(i,:) = table(i).yfreq.sd.translation.fw.(['w',num2str(width(j))]);
        sdcw.(['w',num2str(width(j))])(i,:) = table(i).yfreq.sd.rotation.cw.(['w',num2str(width(j))]);
        sdccw.(['w',num2str(width(j))])(i,:) = table(i).yfreq.sd.rotation.ccw.(['w',num2str(width(j))]);
        % delay 
        delaybw.(['w',num2str(width(j))])(i,:) = table(i).delay.translation.bw.(['w',num2str(width(j))]);
        delayfw.(['w',num2str(width(j))])(i,:) = table(i).delay.translation.fw.(['w',num2str(width(j))]);
        delaycw.(['w',num2str(width(j))])(i,:) = table(i).delay.rotation.cw.(['w',num2str(width(j))]);
        delayccw.(['w',num2str(width(j))])(i,:) = table(i).delay.rotation.ccw.(['w',num2str(width(j))]);
        % background rawmean 
        bgbw.mean.(['w',num2str(width(j))])(i,:) = table(i).background.rawmean.translation.bw.(['w',num2str(width(j))]);
        bgfw.mean.(['w',num2str(width(j))])(i,:) = table(i).background.rawmean.translation.fw.(['w',num2str(width(j))]);
        bgcw.mean.(['w',num2str(width(j))])(i,:) = table(i).background.rawmean.rotation.cw.(['w',num2str(width(j))]);
        bgccw.mean.(['w',num2str(width(j))])(i,:) = table(i).background.rawmean.rotation.ccw.(['w',num2str(width(j))]);
        % background rawsd 
        bgbw.sd.(['w',num2str(width(j))])(i,:) = table(i).background.rawsd.translation.bw.(['w',num2str(width(j))]);
        bgfw.sd.(['w',num2str(width(j))])(i,:) = table(i).background.rawsd.translation.fw.(['w',num2str(width(j))]);
        bgcw.sd.(['w',num2str(width(j))])(i,:) = table(i).background.rawsd.rotation.cw.(['w',num2str(width(j))]);
        bgccw.sd.(['w',num2str(width(j))])(i,:) = table(i).background.rawsd.rotation.ccw.(['w',num2str(width(j))]);
    end
    % background sum
    bg1(i) = table(i).background.sum(1);
    bg2(i) = table(i).background.sum(2);
    % Temp
    tmin(i) = table(i).Temp(1);
    tmed(i) = table(i).Temp(2);
    tmax(i) = table(i).Temp(3);
end

for j = 1 : 3 % stripe width
    % yfreq mean
    meanData.yfreq.mean.translation.bw.(['w',num2str(width(j))]) = median(meanbw.(['w',num2str(width(j))]));
    meanData.yfreq.mean.translation.fw.(['w',num2str(width(j))]) = median(meanfw.(['w',num2str(width(j))]));
    meanData.yfreq.mean.rotation.cw.(['w',num2str(width(j))]) = median(meancw.(['w',num2str(width(j))]));
    meanData.yfreq.mean.rotation.ccw.(['w',num2str(width(j))]) = median(meanccw.(['w',num2str(width(j))]));
    % yfreq sd
    meanData.yfreq.sd.translation.bw.(['w',num2str(width(j))]) = median(sdbw.(['w',num2str(width(j))]));
    meanData.yfreq.sd.translation.fw.(['w',num2str(width(j))]) = median(sdfw.(['w',num2str(width(j))]));
    meanData.yfreq.sd.rotation.cw.(['w',num2str(width(j))]) = median(sdcw.(['w',num2str(width(j))]));
    meanData.yfreq.sd.rotation.ccw.(['w',num2str(width(j))]) = median(sdccw.(['w',num2str(width(j))]));
    % delay
    meanData.delay.translation.bw.(['w',num2str(width(j))]) = median(delaybw.(['w',num2str(width(j))]));
    meanData.delay.translation.fw.(['w',num2str(width(j))]) = median(delayfw.(['w',num2str(width(j))]));
    meanData.delay.rotation.cw.(['w',num2str(width(j))]) = median(delaycw.(['w',num2str(width(j))]));
    meanData.delay.rotation.ccw.(['w',num2str(width(j))]) = median(delayccw.(['w',num2str(width(j))]));
    % background rawmean
    meanData.background.rawmean.translation.bw.(['w',num2str(width(j))]) = median(bgbw.mean.(['w',num2str(width(j))]));
    meanData.background.rawmean.translation.fw.(['w',num2str(width(j))]) = median(bgfw.mean.(['w',num2str(width(j))]));
    meanData.background.rawmean.rotation.cw.(['w',num2str(width(j))]) = median(bgcw.mean.(['w',num2str(width(j))]));
    meanData.background.rawmean.rotation.ccw.(['w',num2str(width(j))]) = median(bgccw.mean.(['w',num2str(width(j))]));
    % background rawsd
    meanData.background.rawsd.translation.bw.(['w',num2str(width(j))]) = median(bgbw.sd.(['w',num2str(width(j))]));
    meanData.background.rawsd.translation.fw.(['w',num2str(width(j))]) = median(bgfw.sd.(['w',num2str(width(j))]));
    meanData.background.rawsd.rotation.cw.(['w',num2str(width(j))]) = median(bgcw.sd.(['w',num2str(width(j))]));
    meanData.background.rawsd.rotation.ccw.(['w',num2str(width(j))]) = median(bgccw.sd.(['w',num2str(width(j))]));
end
meanData.background.sum = [median(bg1) median(bg2)];
meanData.Temp = [min(tmin) median(tmed) max(tmax)];

