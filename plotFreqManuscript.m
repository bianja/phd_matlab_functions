function [] = plotFreqManuscript(data, type, dir, col, a, b, CI)

units = size(struct2table(data),1);

x2 = [5.625 11.25 56.25 112.5 225 450 675 900 1125 1350]; x2 = x2 * 0.0889;
x4 = [8.4375 16.875 84.375 168.75 337.5 675 1012.5 1350 1687.5 2025]; x4 = x4 * 0.0444;
x8 = [14.0625 28.125 140.625 281.25 562.5 1125 1687.5 2250 2812.5]; x8 = x8 * 0.0222;

x2 = [5.625 11.25 56.25 112.5 225 450 675 900 1125 1350]; 
x4 = [8.4375 16.875 84.375 168.75 337.5 675 1012.5 1350 1687.5 2025]; 
x8 = [14.0625 28.125 140.625 281.25 562.5 1125 1687.5 2250 2812.5]; 

for k = 1 : units
    subplot(a,b,k)
    hold on   
    if k == 1
        xlabel('temporal frequency (Hz)')
        ylabel('spike rate (s^-^1)')
    end
    set(gca,'XScale','log')
    lim = get(gca,'xlim');
    temp = [data(k).R01.background.rawmean.translation.fw.w2 data(k).R01.background.rawmean.translation.fw.w4 data(k).R01.background.rawmean.translation.fw.w8...
        data(k).R01.background.rawmean.translation.bw.w2 data(k).R01.background.rawmean.translation.bw.w4 data(k).R01.background.rawmean.translation.bw.w8...
        data(k).R01.background.rawmean.rotation.cw.w2 data(k).R01.background.rawmean.rotation.cw.w4 data(k).R01.background.rawmean.rotation.cw.w8...
        data(k).R01.background.rawmean.rotation.ccw.w2 data(k).R01.background.rawmean.rotation.ccw.w4 data(k).R01.background.rawmean.rotation.ccw.w8];
    set(gca,'xlim',[10^-1 10^3],'xtick',[10^-1 10^0 10^1 10^2],'xticklabels',{'','1','10','100'})
    set(gca,'xlim',[10^0 10^4],'xtick',[10^0 10^1 10^2 10^3],'xticklabels',{'','10','100','1000'})
%     patch([10^-2 10^3 10^3 10^-2], [mean(temp)-2*std(temp) mean(temp)-2*std(temp), mean(temp)+2*std(temp) mean(temp)+2*std(temp)], [0.85 0.85 0.85],'EdgeColor','none','FaceAlpha',.5)
    patch([10^-2 10^4 10^4 10^-2], [mean(temp)+CI(k,1) mean(temp)+CI(k,1), mean(temp)-abs(CI(k,2)) mean(temp)-abs(CI(k,2))], [0.85 0.85 0.85],'EdgeColor','none','FaceAlpha',.5)
    line([10^-2 10^4],[mean(temp) mean(temp)],'LineStyle','--','LineWidth',1,'Color',[0.5 0.5 0.5])
    plot(x2, data(k).R01.yfreq.mean.(char(type)).(char(dir)).w2,'-', 'Color', col, 'LineWidth', 1)
    plot(x4, data(k).R01.yfreq.mean.(char(type)).(char(dir)).w4,'-', 'Color', col, 'LineWidth', 2)
    plot(x8, data(k).R01.yfreq.mean.(char(type)).(char(dir)).w8(1:end-1),'-', 'Color', col, 'LineWidth', 3)
    set(gca,'Box','on')
end




