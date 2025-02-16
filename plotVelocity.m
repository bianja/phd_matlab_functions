function [] = plotVelocity(vel, data, col, marker,bg)
% data is struct with all units to analyse(e.g. data.unit01; data.unit02; ..)

% calculate number of units to plot and set numbers of subplots
units = size(struct2table(data),2);
if rem(units,2) == 0 % even 
    b = units/2;
else % uneven
    b = (units+1)/2;
end

% figure
for k = 1 : units
    subplot(b,2,k)
    hold on
    plot(vel, data.(['unit0',num2str(k)]),marker,'Color',col,'LineWidth',1.5)
    xlabel('velocity (°/s)')
    ylabel('spike rate (s-1)')
    set(gca,'XScale','log')
    % ylim([ax(1,k) ax(2,k)])   
    plot([10^0 10^4], [bg.(['unit0',num2str(k)])(1) bg.(['unit0',num2str(k)])(1)],'--','Color',[.5 .5 .5],'LineWidth',1.5)
    axis square
    box on
    xlim([10^.5 10^3.5])
end




