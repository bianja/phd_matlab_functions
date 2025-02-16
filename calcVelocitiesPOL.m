function [velocity, turns, diffTime] = calcVelocitiesPOL(times, steps)
%
% INPUT
% times = 
% steps =
%
% OUTPUT
% velocity = 
% turns = 
% diffTime = 
%
% EXAMPLE
% calcVelocitiesPOL(times, steps)

% find regions between times, which show rotating pol pattern
% check whether POL light is on
% are there steps between times?

% diff(times)

for i = 1 : length(times)-1
    temp = sum(find(steps > times(i) & steps < times(i+1)));
    if temp > 1 % there are steps -> stimulus -> calculate velocity
        turns(i) = temp/800; % count number of steps (this is already given by temp) and number of turns
        diffTime(i) = times(i+1)-times(i); % get stimulus duration
        velocity(i) = (360*turns(i))/diffTime(i); % calculate movement velocity
    else % no steps -> no stimulus -> do nothing
    end
end
% calculate velocities from diff(times) 