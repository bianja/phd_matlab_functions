function [] = plotFreq2(data, type, dir, col)
% data is struct with all units to analyse(e.g. data.unit01; data.unit02; ..)

% calculate number of units to plot and set numbers of subplots
units = size(struct2table(data),1);
% units = 1;
% if rem(units,2) == 0 % even 
%     b = units/2;
%     e = 1;
% else % uneven
%     b = (units+1)/2;
%     e = 1;
% end


% if rem(units,2) == 0 % even 
%     b = units/2;
%     e = 2;
% else % uneven
%     b = (units+1)/2;
%     e = 2;
% end



% if rem(units,2) == 0 % even 
%     b = units/6;
% else % uneven
%     b = (units+1)/6;
% end

% e = 12; b = 11;


% figure
for k = 1 : units
    subplot(5,4,k)
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
    set(gca,'xlim',[10^-2 10^3],'xtick',[10^-1 10^0 10^1 10^2],'xticklabels',{'0.1','1','10','100'})
    patch([10^-2 10^3 10^3 10^-2], [mean(temp)-2*std(temp) mean(temp)-2*std(temp), mean(temp)+2*std(temp) mean(temp)+2*std(temp)], [0.85 0.85 0.85],'EdgeColor','none','FaceAlpha',.5)
    line([10^-2 10^3],[mean(temp) mean(temp)],'LineStyle','--','LineWidth',1,'Color',[0.5 0.5 0.5])
    plot(data(k).xfreq.w2, data(k).R01.yfreq.mean.(char(type)).(char(dir)).w2,'-', 'Color', col, 'LineWidth', 1)
    plot(data(k).xfreq.w4, data(k).R01.yfreq.mean.(char(type)).(char(dir)).w4,'-', 'Color', col, 'LineWidth', 2)
    plot(data(k).xfreq.w8, data(k).R01.yfreq.mean.(char(type)).(char(dir)).w8,'-', 'Color', col, 'LineWidth', 3)
    set(gca,'Box','on')
 
%     line([10^-2 10^3],[mean(temp)+2*std(temp) mean(temp)+2*std(temp)],'LineStyle','--','LineWidth',1,'Color',[0.5 0.5 0.5])
%     line([10^-2 10^3],[mean(temp)-2*std(temp) mean(temp)-2*std(temp)],'LineStyle','--','LineWidth',1,'Color',[0.5 0.5 0.5])
%     title(['Ani: ',num2str(data(k).Animal),'(',num2str(data(k).UnitNbr),'), rep: ', num2str(data(k).rep)])
%     title([num2str(type),', ',num2str(dir)])
%     title(['Ani #: ',num2str(data(k).Animal),', Unit #: ',num2str(data(k).UnitNbr),', # of rep: ', num2str(data(k).rep)])
end




