function [] = Boxplot_B(table,groups,LW,COL,label,posX)
% table =  data (with each column being a separate boxplot and all rows 
% belonging to one boxplot)
% groups = number of different groups
% widths of boxes
% COL = matrix with colors for each box
% label = label x axis for each box 

% example = Boxplot_B(pool.bp,2,6,[0.5 0.5 0.5;0.75 0.75 0.75],{'I','A'})
% example = Boxplot_B(rand(10),2,6,[0.5 0.5 0.5;0.75 0.75 0.75],{'I','A'})

% table = pool.bp;
% groups = 2;
% LW = 6;
% COL = [0.5 0.5 0.5;0.75 0.75 0.75];
% label = {'I','A'};


% create x axis positions of boxplots differentiated by groups
k = 1;
for i = 1 : size(table,2)
    pos(i) = k;
    if rem(i,groups) == 0 % no rest -> gap
        k = k + 2;
    else
        k = k + 1;
    end
end

figure(100)
set(0,'DefaultFigureVisible','off');
boxplot(table,'positions',pos,'Colors',COL,'Symbol','+k','BoxStyle','outline','Widths',1);
set(0,'DefaultFigureVisible','on');
ax = gca();
temp = ax.Children.Children;
temp = temp((groups*3+i):(groups*3+i+groups));
h = findobj(gcf, 'tag', 'Upper Adjacent Value'); up_adjy = cell2mat(get(h,'YData')); up_adjx = cell2mat(get(h,'XData'));
h = findobj(gcf, 'tag', 'Lower Adjacent Value'); lo_adjy = cell2mat(get(h,'YData')); lo_adjx = cell2mat(get(h,'XData'));
close(figure(100))

figure('Name','Boxplot','NumberTitle','off')
boxplot(table,'positions',pos,'Colors',COL,'Symbol','+k','BoxStyle','filled','Widths',1)
% ax = gca();
% temp = ax.Children.Children;
% for i = 1 : groups
%     temp((groups*3+i)).Color = COL(1,:);
%     temp((groups*3+i+groups)).Color = COL(1,:);
% end
% ax = gca();
% temp2 = [ax.Children.Children; temp];
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'w');
lines = findobj(gcf, 'type', 'line', 'Tag', 'Box');
set(lines, 'linewidth', LW)
hold on
COLtemp = flipud(COL);
% close(figure(100))

% bring col vector on same size as number of boxplots
for i = 1 : groups : size(table,2)
    COL2(i:i+groups-1,:) = COLtemp;
end

% this is for the small lines at the end of the whiskers
up_adjx(:,1) = up_adjx(:,1)+0.15;
up_adjx(:,2) = up_adjx(:,2)-0.15;
lo_adjx(:,1) = lo_adjx(:,1)+0.15;
lo_adjx(:,2) = lo_adjx(:,2)-0.15;
for i = 1 : size(table,2)
    plot(up_adjx(i,:),up_adjy(i,:),'Color',COL2(i,:))
    plot(lo_adjx(i,:),lo_adjy(i,:),'Color',COL2(i,:))
end

for i = 1 : groups
    M(i) = '-';
end

% createLegend(labelLegend,COL,M,{'best'},2);
% ylabel('normalized spike rate')
% set(gca, 'ylim', [0,1.05],'fontsize',10);
% clear up_adjx up_adjy lo_adjx lo_adjy temp1 temp2 temp3 lines h colorcode2 cONvT i k files
xlim([0 pos(end)+1])
% ylim([0 1.05])
set(gca,'XTickLabel',label,'XTick',posX)

