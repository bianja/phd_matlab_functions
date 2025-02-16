function [peak, peakval] = findPeak(xfreq,yfreq,background)

% [peakfreq,peakval] = findPeak(xfreq.w2,yfreq.mean.translation.bw.w2,background);

peakvalMax = max(yfreq);
peakvalMin = min(yfreq);
tempMax = xfreq(find(yfreq == peakvalMax));  %#ok<*FNDSB>
tempMin = xfreq(find(yfreq == peakvalMin)); 

% peakvalMin = peakvalMin * (-1);

if peakvalMax-background(1) > (peakvalMin-background(1))*(-1)
    %maximum
    peak = tempMax(1);
    peakval = peakvalMax(1);
%     if peakval > background(1)+10
%     else
%         peak = NaN;
%         peakval = peakvalMin;
%     end
elseif peakvalMax-background(1) < (peakvalMin-background(1))*(-1)
    %minimum
    peak = tempMin(1);
    peakval = peakvalMin(1);
    peakval = peakval(1) * (-1);
%     if peakval < background(1)-10
%     else
%         peak = NaN;
%         peakval = peakvalMin;
%     end
else
    peak = NaN;
    peakval = peakvalMin(1);
end

