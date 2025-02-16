function [peakfreq,peakval,peak,width] = calcPeakFreqNORM(xfreq,yfreq,peak,width)

[peakfreq.bw.w2,peakval.bw.w2] = findPeakNORM(xfreq.w2,yfreq.mean.translation.bw.w2);
[peakfreq.bw.w4,peakval.bw.w4] = findPeakNORM(xfreq.w4,yfreq.mean.translation.bw.w4);
[peakfreq.bw.w8,peakval.bw.w8] = findPeakNORM(xfreq.w8,yfreq.mean.translation.bw.w8);

[peakfreq.fw.w2,peakval.fw.w2] = findPeakNORM(xfreq.w2,yfreq.mean.translation.fw.w2);
[peakfreq.fw.w4,peakval.fw.w4] = findPeakNORM(xfreq.w4,yfreq.mean.translation.fw.w4);
[peakfreq.fw.w8,peakval.fw.w8] = findPeakNORM(xfreq.w8,yfreq.mean.translation.fw.w8);
