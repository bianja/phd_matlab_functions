function [group, fw, bw] = createGroupsOF(activity, background, standardDeviation, displayDecision)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% to quantify response of unit to backwards and forewards translational
% movement (but would also work for translation) and subsequently assign
% unit to one of five response groups 
%
% INPUT
% activity = vector containing spike rate values
% background = contains background activity for each value of activity
% standardDeviation = contains standard deviation from mean for each value
% displayDecision = 'Y' is text response
%
% OUTPUT
% group = number between 1 and 5, which assigns unit to group based on its
% response to stimuli
% 1 = exc. bidir.
% 2 = exc. unidir.
% 3 = exc. inh.
% 4 = inh. unidir.
% 5 = inh. bidir
% 6 = no group matches unit response
%
% EXAMPLE
% createGroupsOF(AllAni(1).yfreq.mean.translation, AllAni(1).background.rawmean.translation, AllAni(1).background.rawsd.translation,'N')
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% quantify response to fw movement direction
fwt(1) = classifyGroups(activity.fw.w2, background.fw.w2, standardDeviation.fw.w2,'N');
fwt(2) = classifyGroups(activity.fw.w4, background.fw.w4, standardDeviation.fw.w4,'N');
fwt(3) = classifyGroups(activity.fw.w8, background.fw.w8, standardDeviation.fw.w8,'N');
if length(unique(fwt)) == 3
    % each possible outcome, no decision possible
    fw = NaN;
else
    [~, pos] = unique(fwt);
    dup = find(ismember(1:3,pos)==0);
    fw = fwt(dup(1));
end

% quantify response to bw movement direction
bwt(1) = classifyGroups(activity.bw.w2, background.bw.w2, standardDeviation.bw.w2,'N');
bwt(2) = classifyGroups(activity.bw.w4, background.bw.w4, standardDeviation.bw.w4,'N');
bwt(3) = classifyGroups(activity.bw.w8, background.bw.w8, standardDeviation.bw.w8,'N');
if length(unique(bwt)) == 3
    % each possible outcome, no decision possible
    bw = NaN;
else
    [~, pos] = unique(bwt);
    dup = find(ismember(1:3,pos)==0);
    bw = bwt(dup(1));
end

% assign to group
if displayDecision == 'Y'
    if fw == 2 && bw == 2 % exc. bidir
        disp('group 1')
        group = 1;
    elseif fw == 2 && bw == 0 || fw == 0 && bw == 2 % exc. unidir.
        disp('group 2')
        group = 2;
    elseif fw == 2 && bw == 1 || fw == 1 && bw == 2 % exc. inh.
        disp('group 3')
        group = 3;
    elseif fw == 1 && bw == 0 || fw == 0 && bw == 1 % inh. unidir.
        disp('group 4')
        group = 4;
    elseif fw == 1 && bw == 1 % inh. bidir
        disp('group 5')
        group = 5;
    else
        group = 6;
        disp('units fits to none of the defined groups')
    end
else
    if fw == 2 && bw == 2 % exc. bidir
        group = 1;
    elseif fw == 2 && bw == 0 || fw == 0 && bw == 2 % exc. unidir.
        group = 2;
    elseif fw == 2 && bw == 1 || fw == 1 && bw == 2 % exc. inh.
        group = 3;
    elseif fw == 1 && bw == 0 || fw == 0 && bw == 1 % inh. unidir.
        group = 4;
    elseif fw == 1 && bw == 1 % inh. bidir
        group = 5;
    else
        group = 6;
    end
end