function [freq] = calcFrequency(vel, stripeWidth)

% Input: velocity data
% Output: frequency data

x = (360/128)*(2+stripeWidth);
freq = vel/x;