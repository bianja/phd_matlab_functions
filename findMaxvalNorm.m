function [dir, width, maxpos, maxmum] = findMaxvalNorm(yfreq,xfreq,peakBW,peakFW)

% example = [dir, width] = findMaxvalNorm(AllAni.yfreq,AllAni.xfreq,peakBW,peakFW)
temp = find(xfreq.w2 == peakBW(1));
maxval(1) = yfreq.mean.translation.bw.w2(temp(1));
temp = find(xfreq.w4 == peakBW(2));
maxval(2) = yfreq.mean.translation.bw.w4(temp(1));
temp = find(xfreq.w8 == peakBW(3));
maxval(3) = yfreq.mean.translation.bw.w8(temp(1));

temp = find(xfreq.w2 == peakFW(1));
maxval(4) = yfreq.mean.translation.fw.w2(temp(1));
temp = find(xfreq.w4 == peakFW(2));
maxval(5) = yfreq.mean.translation.fw.w4(temp(1));
temp = find(xfreq.w8 == peakFW(3));
maxval(6) = yfreq.mean.translation.fw.w8(temp(1));


maxpos = find(maxval == max(maxval));
maxmum = maxval(maxpos);

maxmum = maxmum(1);
maxpos = maxpos(1);

if maxpos <= 3
    dir = 'bw';
elseif maxpos > 3
    dir = 'fw';
end

if maxpos == 1 || maxpos == 4
    width = 'w2';
elseif maxpos == 2 || maxpos == 5
    width = 'w4';
elseif maxpos == 3 || maxpos == 6
    width = 'w8';
end

clear maxpos
maxpos = temp;