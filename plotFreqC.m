function [] = plotFreqC(Data, type, dir, R, col)
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
    plot(Data(k).xfreq.w8, Data(k).(['R0',num2str(R)]).yfreq.mean.(char(type)).(char(dir)).w8,'-x', 'Color', col, 'LineWidth', 2)

    set(gca,'XScale','log')
    lim = get(gca,'xlim');
    set(gca,'xlim',[10^-2 10^3],'xtick',[10^-1 10^0 10^1 10^2],'xticklabels',{'0.1','1','10','100'},'Box','on')
    bg = Data(k).(['R0',num2str(R)]).background.sum(1);
    line([10^-2 10^3],[bg bg],'LineStyle','--','LineWidth',1,'Color',[0.5 0.5 0.5])
%     title(['Ani #: ',num2str(data(k).Animal),', Unit #: ',num2str(data(k).UnitNbr),', # of rep: ', num2str(data(k).rep)])
end




