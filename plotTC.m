function [] = plotTC(AllAni,i,dir2)
figure
hold on
for j = 1 : 6
    if ~isempty(AllAni(i).(['R0',num2str(j)]))
        plot(AllAni(i).xfreq.w8, AllAni(i).(['R0',num2str(j)]).yfreq.mean.translation.(char(dir2)).w8,'-','LineWidth',j/2,'Color',[(AllAni(i).(['R0',num2str(j)]).Temp(2)-20)/16 0 0])
    end
end
plot([10^-1 10^2],[0 0],'--','Color',[.7 .7 .7 .5],'LineWidth',1.5)

box on
ylabel('spike rate (s^-^1)')
xlabel('temporal frequency (Hz)')
title(['Ani: ',num2str(AllAni(i).Animal), ' Unit: ', num2str(AllAni(i).UnitNbr),' Dir: ',char(dir2)])
axis square 
set(gcf,'Position',[820 150 320 330])
set(gca,'xscale','log','XTick',[1,10,100],'XTickLabels',{'1','10','100'},'Xlim',[10^-0.65 10^2])
