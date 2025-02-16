function [] = plotVelocity2(data, type, dir, col)
% data is struct with all units to analyse(e.g. data.unit01; data.unit02; ..)

% calculate number of units to plot and set numbers of subplots
units = size(struct2table(data),1);
if rem(units,2) == 0 % even 
    b = units/2;
else % uneven
    b = (units+1)/2;
end

if rem(units,2) == 0 % even
    b = units/6;
else % uneven
    b = (units+1)/6;
end

% figure
for k = 1 : units
    subplot(b,6,k)
    hold on
    plot(data(k).xvelo.w2, data(k).R01.yfreq.mean.(char(type)).(char(dir)).w2,'-x', 'Color', col, 'LineWidth', 1)
    plot(data(k).xvelo.w4, data(k).R01.yfreq.mean.(char(type)).(char(dir)).w4,'-x', 'Color', col, 'LineWidth', 2)
    plot(data(k).xvelo.w8, data(k).R01.yfreq.mean.(char(type)).(char(dir)).w8,'-x', 'Color', col, 'LineWidth', 3)
    if k == 25
        xlabel('velocity (°/s)')
        ylabel('spike rate (s-1)')
    end
    set(gca,'XScale','log')
%     lim = get(gca,'xlim');
    set(gca,'xlim',[10^0 10^4],'xtick',[10^1 10^2 10^3],'xticklabels',{'10','100','1000'})
    line([10^0 10^4],[data(k).R01.background(1) data(k).R01.background(1)],'LineStyle','--','LineWidth',1,'Color',[0.5 0.5 0.5])
end




