function [] = plotFreqStim(AllAni, width, dir)

% width = 8;
% dir = 'bw';

for i = 1 : size(AllAni,2)
    normVal = [AllAni(i).R01.yfreq.mean.translation.fw.w2 - AllAni(i).R01.background.rawmean.translation.fw.w2 AllAni(i).R01.yfreq.mean.translation.fw.w4 - AllAni(i).R01.background.rawmean.translation.fw.w4...
        AllAni(i).R01.yfreq.mean.translation.fw.w8 - AllAni(i).R01.background.rawmean.translation.fw.w8 AllAni(i).R01.yfreq.mean.translation.bw.w2 - AllAni(i).R01.background.rawmean.translation.bw.w2...
        AllAni(i).R01.yfreq.mean.translation.bw.w4 - AllAni(i).R01.background.rawmean.translation.bw.w4 AllAni(i).R01.yfreq.mean.translation.bw.w8 - AllAni(i).R01.background.rawmean.translation.bw.w8];
    temp(i,:) = (AllAni(i).R01.yfreq.mean.translation.(char(dir)).(['w',num2str(width)]) - AllAni(i).R01.background.rawmean.translation.(char(dir)).(['w',num2str(width)]))/max(normVal);
end

figure
plot([.5 1 5 10 20 40 60 80 100 120], temp, 'Color', [.4 .4 .4], 'LineWidth',1.2)
set(gca,'XScale','log','Box','on')
set(gcf,'position',[1000 500 315 290])
ylim([-0.5 1])
