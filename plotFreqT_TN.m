function [] = plotFreqT_TN(Data, type, dir, s1, s2, RespDir)
% data is struct with all units to analyse(e.g. data.unit01; data.unit02; ..)

units = size(struct2table(Data),1);
for k = 1 : units
    subplot(s1,s2,k)
    hold on    
    meanT1 = median([Data(k).R02.yfreq.mean.(char(type)).(char(dir)).w8; Data(k).R03.yfreq.mean.(char(type)).(char(dir)).w8]);
    meanT2 = median([Data(k).R05.yfreq.mean.(char(type)).(char(dir)).w8; Data(k).R06.yfreq.mean.(char(type)).(char(dir)).w8]);
    meanT3 = [Data(k).R07.yfreq.mean.(char(type)).(char(dir)).w8];
    maxval = [meanT1 meanT2];
    switch RespDir
        case 'E'
            plot(Data(k).xfreq.w8, meanT1/max(meanT1),'-', 'Color', [158/255 1/255 66/255], 'LineWidth', 1.5)
            plot(Data(k).xfreq.w8, meanT2/max(meanT2),'-', 'Color', [5/255 48/255 97/255], 'LineWidth', 1.5)
%             plot(Data(k).xfreq.w8, meanT3/max(meanT3),'--', 'Color', [158/255 1/255 66/255 1], 'LineWidth', 1.5)
        case 'I'
            meanT1 = (meanT1-min(maxval))./(max(maxval)-min(maxval));
            meanT2 = (meanT2-min(maxval))./(max(maxval)-min(maxval));
            plot(Data(k).xfreq.w8, meanT1,'-', 'Color', [158/255 1/255 66/255], 'LineWidth', 1.5)
            plot(Data(k).xfreq.w8, meanT2,'-', 'Color', [5/255 48/255 97/255], 'LineWidth', 1.5)
%             plot(Data(k).xfreq.w8, meanT3,'--', 'Color', [158/255 1/255 66/255 1], 'LineWidth', 1.5)
        otherwise
            display('dir needs to be I for inhibitory responses or E for excitatory responses.')
    end
    set(gca,'XScale','log')
    lim = get(gca,'xlim');
    set(gca,'xlim',[10^-2 10^3],'xtick',[10^-1 10^0 10^1 10^2],'xticklabels',{'0.1','1','10','100'},'Box','on')
    %     bg = [Data(k).R01.background.sum(1) Data(k).R02.background.sum(1) Data(k).R03.background.sum(1)];
    %     line([10^-2 10^3],[median(bg) median(bg)],'LineStyle','--','LineWidth',1,'Color',[0.5 0.5 0.5])
    %     title(['Ani #: ',num2str(data(k).Animal),', Unit #: ',num2str(data(k).UnitNbr),', # of rep: ', num2str(data(k).rep)])
end




