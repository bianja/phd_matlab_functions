function [] = Time_Spikes(data, stim_times_start, stim_times_end, rec, background)

% plot time course of units
%
% INPUT
% data = raw data of unit
% stim_times_start = start time for each stimulus
% stim_times_end = end time for each stimulus
% rec = sequence of stimuli 
% background = bg activity (raw data)
%
% OUTPUT
%
% EXAMPLE
% Time_Spikes(Ch19, stim_times_start, stim_times_end, rec, background)
%
% need to adapt type of stim (e.g. translation, width, velocity for bw or
% fw) and also ylimits and unit numer for background activity
% also, run Script_really_right_frequency before running this function


figure(101)
close
figure(102)
close
figure(103)
close

clear spikes_bins stim_bins bins
binSize = .5;
% mult = 1/binSize;
ylimit = 30;
add = 5;

% length of 5 s stimulus; take 1 s before and 1 s after stimulus; 0.2 s
% bins
for j = 1 : length(stim_times_start)
    bins = stim_times_start(j)-add : binSize : stim_times_end(j)+add;
    for i = 1 : length(bins)-1
        stim_bins(i) = length(data.times(find(data.times > bins(i) & data.times < bins(i+1))));
    end
    spikes_bins(j,:) = stim_bins; %*mult; % this is to have spikes/s (but I could also say spikes/20 ms or so)
end




j = find(contains({rec.type},'translational') & [rec.width] == 8 & [rec.vel] > 0);
% sort j so that velocity is increasing
velo = [0.5 1 5 10 20 40 60 80 100 120];
% velo = [-0.5 -1 -5 -10 -20 -40 -60 -80 -100 -120];
temp = [rec(j).vel];
[~,idx] = sort(abs(temp));
j = j(idx);

c = 1;

figure(102)
x = [add add+5]; x2 = [x, fliplr(x)]; % set x values for square
y1 = [0 0]; y2 = [ylimit ylimit]; y = [y1, fliplr(y2)]; % set y value for square
h = fill(x2, y, [0.8 0.8 0.8],'edgecolor',[0.9 0.9 0.9]); % set square in a light greyish color without edges
set(h,'facealpha',.5) % transparency
    
for i = j(2:4:end) %[2 4 10 16 20 21 25 35 39 42 47 48 49 58 60 71 72 73 74 82 83 90 94 95 104 106 109 112 114 115 120]; % 122 125 136 137 141 142 150 151 155 163]
    figure(100)
    plot(binSize/2 : binSize : 2*add+5,spikes_bins(i,:),'k-')
    % coloured square to mark stimulus
    temp = get(gca,'YLim');
    close
    figure(101)
    subplot(2,5,c)
    hold on
    x = [add add+5]; x2 = [x, fliplr(x)]; % set x values for square
    y1 = [0 0]; y2 = [ylimit ylimit]; y = [y1, fliplr(y2)]; % set y value for square
    h = fill(x2, y, [0.8 0.8 0.8],'edgecolor',[0.9 0.9 0.9]); % set square in a light greyish color without edges
    set(h,'facealpha',.5) % transparency
    % plot data
    plot(binSize/2 : binSize : 2*add+5,spikes_bins(i,:),'-','LineWidth',2,'Color',[(c/2)*.3/3 (c/2)*.3/3 (c/2)*.3/3])
%     plot(binSize/2 : binSize : 2*add+5,smooth(spikes_bins(i,:),0.2,'loess'),'-','LineWidth',2,'Color',[.3 .3 .3])
%     plot(binSize/2 : binSize : 2*add+5,sgolayfilt(spikes_bins(i,:),3, 51),'-','LineWidth',2,'Color',[.3 .3 .3])
%     plot([0 7],[background.raw.unit03(i) background.raw.unit03(i)],'--','Color',[.5 .5 .5],'LineWidth', 1.2)
    title([num2str([rec(i).vel]), ', ' num2str([rec(i).width]),', ', num2str(rec(i).type(1))])
%     ylim([0 temp(2)])
    ylim([0 ylimit])
    xlim([0 add+5+add])
    
    figure(102)
    hold on
    % plot data
    plot(binSize : binSize : 2*add+5,spikes_bins(i,:),'-','LineWidth',1.5,'Color',[(c/2)*.3/3 (c/2)*.3/3 (c/2)*.3/3])%[rec(i).vel]/255+0.4])
%     plot(binSize/2 : binSize : 2*add+5,smooth(spikes_bins(i,:),0.2,'loess'),'-','LineWidth',2,'Color',[.0 .0 .5])%[rec(i).vel]/255+0.4])
%     plot(binSize/2 : binSize : 2*add+5,sgolayfilt(spikes_bins(i,:),3,51),'-','LineWidth',2,'Color',[.0 .0 .5])%[rec(i).vel]/255+0.4])
    title([num2str([rec(i).width]),', ', num2str(rec(i).type(1))])
    ylim([0 ylimit])
    xlim([0 add+5+add])

    if c == 4
        plotlarge = spikes_bins(i,:);
    end
   
    c = c + 1;
end

figure(103)
hold on
x = [add add+5]; x2 = [x, fliplr(x)]; % set x values for square
y1 = [0 0]; y2 = [ylimit ylimit]; y = [y1, fliplr(y2)]; % set y value for square
h = fill(x2, y, [0.8 0.8 0.8],'edgecolor',[0.9 0.9 0.9]); % set square in a light greyish color without edges
set(h,'facealpha',.5) % transparency
plot(binSize/2 : binSize : 2*add+5,plotlarge,'-','LineWidth',2,'Color',[(4/2)*.3/3 (4/2)*.3/3 (4/2)*.3/3])
ylim([0 ylimit])
xlim([0 add+5+add])
ylabel(['spikes / ',num2str(binSize),' ms'])
xlabel('time (s)')
set(gca,'Box','on')


figure(101)
set(gcf,'position',[656 415 1011 323])
subplot(2,5,6)
ylabel(['spikes / ',num2str(binSize),' ms'])
subplot(2,5,8)
xlabel('time (s)')

figure(102)
ylabel(['spikes / ',num2str(binSize),' ms'])
xlabel('time (s)')



