function [peak, peakval] = findPeakNORM(xfreq,yfreq)


peakvalMax = max(yfreq);
tempMax = xfreq(find(yfreq == peakvalMax));  %#ok<*FNDSB>
peak = tempMax(1);
peakval = peakvalMax(1);

