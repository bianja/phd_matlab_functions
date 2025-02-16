function [] = plotRaw(time, d1, d2, d3, d4, stimstart, stimend)  %#ok<*INUSL>

figure
for i = 1 : 4
    a = find(eval(['d', num2str(i)]).times > time(1), 1);
    b = find(eval(['d', num2str(i)]).times > time(2), 1);
    subplot(4,1,i)
    hold on
    plot(eval(['d', num2str(i)]).times(a:b),eval(['d', num2str(i)]).values(a:b),'Color',[0 0 0]);
    set(gca,'ytick','','yticklabels','','Box','off','xtick','','xticklabels','')
    xlim(time)
end

yax1 = zeros(1,4);
yax2 = zeros(1,4);
for i = 1 : 4
    temp = get(gca,'ylim');
    yax1(i) = temp(1);
    yax2(i) = temp(2);
end

yval1 = max(yax1);
yval2 = max(yax2);

c = (abs(yval1)+abs(yval2))*0.1;

for i = 1 : 4
    subplot(4,1,i)
    set(gca,'ylim',[yval1-c yval2+c])
    axis off
    
    if length(stimstart) ~= length(stimend)
        error('start and end vectors need to have same sizes')
    else
    for k = 1 : length(stimstart)
        x = [stimstart(k) stimend(k)]; x2 = [x, fliplr(x)];
        y1 = [-2 -2]; y2 = [2 2]; y = [y1, fliplr(y2)];
        h = fill(x2,y,[0.6 0.6 0.6],'edgecolor','none');
        set(h,'facealpha',.4)
    end
    end
end