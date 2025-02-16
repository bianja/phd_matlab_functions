function [] = meanTC(xval, AllAni)

% plot all data of yval over xval and plot mean of yval
%
% INPUT
% xval - x values (one vector) 
% yval - y values %% (array, line = one dataset, columns = different values of testing parameters)
%
% OUTPUT
% figure
%
% EXAMPLE
% meanTC(xval, yval)


% array for yvalues
for i = 1 : size(AllAni,2)
    maxval = max(AllAni(i).yfreq.mean.translation.bw.w2);
    yvalbw(i,:) = AllAni(i).yfreq.mean.translation.bw.w2/maxval;
    maxval = max(AllAni(i).yfreq.mean.translation.fw.w2);
    yvalfw(i,:) = AllAni(i).yfreq.mean.translation.fw.w2/maxval;
end


figure
hold on
for i = 1 : size(yvalbw,1)
    plot(xval,yvalbw(i,:))
end
plot(xval,mean(yvalbw),'k','LineWidth',2)
xlabel('velocity (°/s)')
ylabel('spike rate (s-1)')
set(gca,'XScale','log')
lim = get(gca,'xlim');
set(gca,'xlim',[0.4 150],'xtick',[10^-1 10^0 10^1 10^2],'xticklabels',{'0.1','1','10','100'})
    
    
figure
hold on
for i = 1 : size(yvalfw,1)
    plot(xval,yvalfw(i,:))
end
plot(xval,mean(yvalfw),'k','LineWidth',2)
xlabel('velocity (°/s)')
ylabel('spike rate (s-1)')
set(gca,'XScale','log')
lim = get(gca,'xlim');
set(gca,'xlim',[0.4 150],'xtick',[10^-1 10^0 10^1 10^2],'xticklabels',{'0.1','1','10','100'})