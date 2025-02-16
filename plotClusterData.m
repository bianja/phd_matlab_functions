function [] = plotClusterData(dataMatrix, groups, x, idx, col, lim)

figure
for i = 1 : groups
    subplot(1,groups,i)
    hold on
    plot(x,dataMatrix(find(idx == i),:)','Color',[col(i,:) .2])%[0 0 0 .2])
    plot(x,median(dataMatrix(find(idx == i),:))','Color',[0.2 0.2 0.2],'LineWidth',1.5)
    set(gca,'XScale','log','Box','on','xtick',[10^-1 10^0 10^1 10^2],'xticklabels',{'0.1','1','10','100'})
    ylim(lim)
end
set(gcf,'Position',[680 520 515 180])
subplot(1,groups,round(groups/2))
xlabel('temporal frequency (Hz)')
subplot(1,groups,1)
ylabel('norm spike rate')