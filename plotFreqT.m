function [] = plotFreqT(Data, type, dir, d, b)
% data is struct with all units to analyse(e.g. data.unit01; data.unit02; ..)

% calculate number of units to plot and set numbers of subplots
% d = 6;
units = size(struct2table(Data),1);
% if rem(units,d) == 0 % even 
%     b = units/d;
% else % uneven
%     b = (units+d-1)/d;
% end
% b = 6;
% figure
for k = 1 : units
    subplot(b,d,k)
    hold on
    plot(Data(k).xfreq.w8, Data(k).R01.yfreq.mean.(char(type)).(char(dir)).w8,'-x', 'Color', [69/255 117/255 180/255], 'LineWidth', 1.5)
    plot(Data(k).xfreq.w8, Data(k).R02.yfreq.mean.(char(type)).(char(dir)).w8,'-x', 'Color', [158/255 1/255 66/255], 'LineWidth', 1.5)
    if isempty(Data(k).R03) == 0
        plot(Data(k).xfreq.w8, Data(k).R03.yfreq.mean.(char(type)).(char(dir)).w8,'-x', 'Color', [5/255 48/255 97/255], 'LineWidth', 1.5)
        bg = [Data(k).R01.background.sum(1) Data(k).R02.background.sum(1) Data(k).R03.background.sum(1)];
    else
        bg = [Data(k).R01.background.sum(1) Data(k).R02.background.sum(1)];
    end
%     if k == 25
%         xlabel('frequency (Hz)')
%         ylabel('spike rate (s-1)')
%     end
    set(gca,'XScale','log')
    lim = get(gca,'xlim');
    set(gca,'xlim',[10^-2 10^3],'xtick',[10^-1 10^0 10^1 10^2],'xticklabels',{'0.1','1','10','100'},'Box','on')
    line([10^-2 10^3],[median(bg) median(bg)],'LineStyle','--','LineWidth',1,'Color',[0.5 0.5 0.5])
%     title(['Ani #: ',num2str(data(k).Animal),', Unit #: ',num2str(data(k).UnitNbr),', # of rep: ', num2str(data(k).rep)])
end




