function [peakFreq, width] = plotFreq(vel, data, col, marker, sd, background)
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
%     errorbar(vel, data.(['unit0',num2str(k)]),sd.(['unit0',num2str(k)]),'x-','Color',col,'LineWidth',1.5)
    plot(vel, data.(['unit0',num2str(k)]),marker,'Color',col,'LineWidth',1.5)
    xlabel('frequency (Hz)')
    ylabel('spike rate (s-1)')    
    set(gca,'XScale','log')
    lim = get(gca,'xlim');
    set(gca,'xlim',[0.05 160], 'xtick', [1 10 100], 'xticklabel',[1 10 100])
    line([0.05 160],[background.(['unit0',num2str(k)])(1) background.(['unit0',num2str(k)])(1)],'LineStyle','--','LineWidth',1,'Color',[0.5 0.5 0.5])
    peakSR(k) = max(data.(['unit0',num2str(k)]))-min(data.(['unit0',num2str(k)])); % this is maximum spike rate (but relative to minimum spike rate level not to 0)
    th = min(data.(['unit0',num2str(k)]))+((max(data.(['unit0',num2str(k)]))-min(data.(['unit0',num2str(k)])))/2); % this is the spike rate value of where spike rate is 50 % of maximal spike rate relative to minimum (so this would be my 50 % th)
%     temp = intersections(vel,data.(['unit0',num2str(k)]),[0 150],[th(k) th(k)]); % intersections of th and tuning curve
%     width(k) = temp(end)-temp(1);

    % for the width I do not ask for full width half maximum as it is
    % normally done, but I ask for all values which are stronger than the
    % set threshold (which is half maximum); so in case I indeed have to
    % peak values, I do not get a wrong width
    width{k} = vel(find(data.(['unit0',num2str(k)]) >= th));
    
    % for the peak I ask for the maximum value; in case of two x values have
    % same maximum we will get two peak values; but what is about values
    % with different maximum values but still both are peaks? find all
    % peaks instead of only asking for maximum value
    temp = data.(['unit0',num2str(k)]);
    clear peakpos
    j = 1;
    for i = 2 : length(vel)-1
        if temp(i) > temp(i-1) && temp(i) > temp(i+1)
            peakpos(j) = vel(i);
            j = j + 1;
        elseif temp(i) > temp(i-1) && temp(i) == temp(i+1)
            peakpos(j) = vel(i);
            j = j + 1; 
        elseif temp(i) == temp(i-1) && temp(i) > temp(i+1)
            peakpos(j) = vel(i);            
            j = j + 1;
        end
    end
    
    if exist('peakpos') == 0
        peakFreq{k} = NaN;
    else
        peakFreq{k} = peakpos;
    end
    
    % if I only want to have peak peak
%     peakFreq{k} = vel(find(data.(['unit0',num2str(k)]) == max(data.(['unit0',num2str(k)]))));
   
%     line([10^-1 11^2],[half half],'LineStyle','-','LineWidth',1,'Color','k')
end


%     errorbar(vel, data.(['unit0',num2str(k)]),sd.(['unit0',num2str(k)]),marker,'Color',col,'LineWidth',1.5)


