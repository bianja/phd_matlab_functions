function [obj] = plotReceptiveField(dataVector,ft,fs,direction,bg,bins,ulim)
% test stimulus
% dataVector = AllAni(2).RF1(1).spikes;
% ft = 20;
% fs = 2;
% direction = 'ccw'; % if negative
% bg = mean(temp);

%% plot spike timings (spikes)
duration = (360/calcVelocity(ft,fs))*5; % duration of stimulus for 5 repetitions
if isempty(dataVector)
else
    figure('Name',['Mean',char(direction),num2str(ft),num2str(fs)],'NumberTitle','off')
    names = num2str(['Mean',num2str([char(direction),num2str(ft),num2str(fs)])]);
%     obj = CircHist(dataVector,36,'areAxialData',false,'parent',polaraxes);
    obj = CircHist(dataVector,bins,'areAxialData',false,'parent',polaraxes,'histType','frequency','binSizeSec',duration/(36));
    obj.setRLim([0 ulim])
    switch direction
        case 'cw'
            set(gca,'ThetaZeroLocation', 'top','ThetaDir','clockwise')
        case 'ccw'
            set(gca,'ThetaZeroLocation', 'top','ThetaDir','counterclockwise')
    end
    h = obj.drawCirc(bg, '-g', 'LineWidth', 2,'Color',[5/255 48/255 97/255]);
end
set(gcf,'position',[830 250 350 300])
