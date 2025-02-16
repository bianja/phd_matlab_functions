function [] = plotSpikeShapes2(data)

% Unit 1
figure
set(gcf, 'Position', [50 50 500 500])
hold on

% spike shape n = 1 : 4 (tetrode)
pos = [0.1 0.3 0.5 0.7];
for i = 1 : 4
    shape = mean(data.values(:,:,i));
    shapesd = std(data.values(:,:,i));
    s = subplot(1,4,i);
    hold on;
    axis square
    box on
    stdshade(data.values(:,:,i),0.5,[0.5 0.5 0.5])
    ylim([-20*10^-5 20*10^-5])
    set(gca,'ytick',[],'xtick',[])
    s.Position = [pos(i) .1 0.19 0.19];
    xlim([0 80])
end
savefig('CS_A144_U3_spikeShapes_T23_2.fig')
print('CS_A144_U3_spikeShapes_T23_2','-dsvg','-r300','-painters')


% figure format -> horizontal, vertical? figure layout size?
