function [] = plotFreqS(Data, type, dir, R)
% data is struct with all units to analyse(e.g. data.unit01; data.unit02; ..)

% calculate number of units to plot and set numbers of subplots
d = 6;
units = size(struct2table(Data),1);
if rem(units,d) == 0 % even 
    b = units/d;
else % uneven
    b = (units+d-1)/d;
end

% figure
for k = 1 : units
    subplot(5,d,k)
    hold on
    plot(Data(k).xfreq.w2, Data(k).(['R0',num2str(R)]).yfreq.mean.(char(type)).(char(dir)).w2,'-', 'Color', [.64 .64 .64], 'LineWidth', 1.5)%[69/255 117/255 180/255], 'LineWidth', 2)
    plot(Data(k).xfreq.w4, Data(k).(['R0',num2str(R)]).yfreq.mean.(char(type)).(char(dir)).w4,'-', 'Color', [.43 .43 .43], 'LineWidth', 1.5)%[4/255 90/255 141/255], 'LineWidth', 2)
    plot(Data(k).xfreq.w8, Data(k).(['R0',num2str(R)]).yfreq.mean.(char(type)).(char(dir)).w8,'-', 'Color', [.21 .21 .21], 'LineWidth', 1.5)%[5/255 48/255 97/255], 'LineWidth', 2)
%     if k == 25
%         xlabel('frequency (Hz)')
%         ylabel('spike rate (s-1)')
%     end
    set(gca,'XScale','log')
    lim = get(gca,'xlim');
    set(gca,'xlim',[10^-2 10^3],'xtick',[10^-1 10^0 10^1 10^2],'xticklabels',{'0.1','1','10','100'},'Box','on')
    bg = Data(k).(['R0',num2str(R)]).background.sum(1);
    line([10^-2 10^3],[bg bg],'LineStyle','--','LineWidth',1,'Color',[0.5 0.5 0.5])
%     title(['Ani #: ',num2str(data(k).Animal),', Unit #: ',num2str(data(k).UnitNbr),', # of rep: ', num2str(data(k).rep)])
end

set(gcf,'Position',[260 42 1004 738])


