function [peakfreq,peakval,peak,width] = calcPeakFreq(xfreq,yfreq,background,peak,width)
% calcPeakFreq(AllAni(1).xfreq,AllAni(1).yfreq,AllAni(1).background,AllAni(1).peak,AllAni(1).width)

[peakfreq.bw.w2,peakval.bw.w2] = findPeak(xfreq.w2,yfreq.mean.translation.bw.w2,background);
[peakfreq.bw.w4,peakval.bw.w4] = findPeak(xfreq.w4,yfreq.mean.translation.bw.w4,background);
[peakfreq.bw.w8,peakval.bw.w8] = findPeak(xfreq.w8,yfreq.mean.translation.bw.w8,background);

[peakfreq.fw.w2,peakval.fw.w2] = findPeak(xfreq.w2,yfreq.mean.translation.fw.w2,background);
[peakfreq.fw.w4,peakval.fw.w4] = findPeak(xfreq.w4,yfreq.mean.translation.fw.w4,background);
[peakfreq.fw.w8,peakval.fw.w8] = findPeak(xfreq.w8,yfreq.mean.translation.fw.w8,background);

