function [] = plotSpikeShapes(data)

% Unit 1

figure
% spike shape n = 1 : 4 (tetrode)
pos = [0.1 0.2 0.3 0.4];
for i = 1 : 4
    subplot(1,4,i)
    hold on
    shape = mean(data.values(:,:,i));
    shapesd = std(data.values(:,:,i));
    stdshade(data.values(:,:,i),0.5,[0.5 0.5 0.5])
    % plot_distribution_prctile(1:80,shape,'Color',[120/255 120/255 120/255],'LineWidth',1.5,'Alpha',0.15,'Prctile',[50])
    ylim([-40*10^-5 40*10^-5])
    set(gca,'ytick',[],'xtick',[])
    xlim([0 60])
    hold on
    plot([0 60],[0 0],'--','Color',[.6 .6 .6],'LineWidth',1.5)
    set(gcf,'Position',[120 675 560 108])
    set(gca,'Box','on')
    % filename = ['A60_C1_T',num2str(i),'_Shape'];
    % print([filename,'.eps'], '-depsc', '-tiff', '-r300', '-painters')
    % print([filename,'.fig'])
end

% savefig('CS_A144_U3_spikeShapes_T29_4.fig')
% print('CS_A144_U3_spikeShapes_T29_4','-dsvg','-r300','-painters')

% figure format -> horizontal, vertical? figure layout size?
