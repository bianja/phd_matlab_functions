function [] = adaptAxes(Allfig)

figNum = get(gcf,'Number');
allFig = figNum-(Allfig-1) : 1 : figNum;
f=gcf;
subNum = findobj(f.Children,'Type','axes');
a = (get(subNum,'position'));

if length(a) == 4
    a = 1;
    x = 1;
    y = 1;
else
    % find number of rows and columns
    for i = 1 : length(a)
        row(i) = a{i}(2); %#ok<*AGROW>
        col(i) = a{i}(1);
    end
    x = numel(unique(row)); % rows
    y = numel(unique(col)); % columns
end

for k = 1 : size(subNum,1)
    minval = zeros(1,length(allFig));
    maxval = zeros(1,length(allFig));
    for i = 1 : length(allFig)
        figure(allFig(i))
        subplot(x,y,k)
        temp = get(gca, 'ylim');
        minval(i) = temp(1);
        maxval(i) = temp(2);
    end
    
    yval(1) = min(minval)-10;
    if yval(1) < 0 || yval(1)-40 < 0
        yval(1) = 0;
    end
    yval(2) = max(maxval)+1;
    
    for i = 1 : length(allFig)
        figure(allFig(i))
        subplot(x,y,k)
        set(gca, 'ylim', yval)
    end
end