function [recFields] = receptiveFieldData(file,unit,firstUnit,numUnit) 
% calculate responses to vertical stripe (for all stimuli) and save it in
% recFields

listing = dir(file);
        
% change/expand so that all receptive field stimuli will be extracted

% load spike file
for i = 1 : size(listing,1)
    if contains(listing(i).name,'T01.mat') == 1 %yes
        T01 = load([listing(i).folder,'\',listing(i).name]);
    elseif contains(listing(i).name,'T02.mat') == 1
        T02 = load([listing(i).folder,'\',listing(i).name]);
    end
end
        
% load stim file
c = 1;
for i = 1 : size(listing,1)
    if contains(listing(i).name,'test_Arena.mat') == 1 %yes
        S{c} = load([listing(i).folder,'\',listing(i).name]);
        c = c + 1;
    end
end

% calculate spikes or save empty vector
if exist('S')
    for i = 1 : size(S,2)
        for s = 1 : 1 %30
            for r = 1 : 1 %5
                stimval = find_spikes_RF(T01,unit,S{1,i}.rec,firstUnit,numUnit);
            end
        end
        recFields = stimval;
    end
else
    recFields = [];
end

