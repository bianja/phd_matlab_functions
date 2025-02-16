function [] = adaptAxesSP(allFig)

minval = zeros(1,length(allFig));
maxval = zeros(1,length(allFig));
for i = 1 : allFig
    subplot(2,2,i)
    temp = get(gca, 'ylim');
    minval(i) = temp(1);
    maxval(i) = temp(2);
end

yval(1) = min(minval)-10;
if yval(1) < 0 || yval(1)-40 < 0
    yval(1) = 0;
end
yval(2) = max(maxval)+1;

for i = 1 : allFig
    subplot(2,2,i)
    set(gca, 'ylim', yval)
end
