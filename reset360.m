function [timesCorrected, timesOUT] = reset360(times)

% for some velocities more than one turn -> adapt values so that only
% values smaller 360 



% ask for highest value (this should be the last value of the vector)
maxval = max(times);

% divide value by 360 -> this is the value I need to set as maximum for for
% loop
loop = maxval/360;

% for loop -> find values which are smaller than 360*i and higher than
% 360*i-360 and substract 360*i-360 from all values
temps = [];
for i = 1 : round(loop)
    temp = times(find(times < 360*i & times > 360*i-360));
    temps = [temps; temp - (360*i-360)]; % new times vector
    timesOUT{i} = temp - (360*i-360); 
end

% output value is a vector with values between 0 and 360
temptimes = sort(temps);

% a = take this vector and find values which are higher 360/2=180; first half
% is totally fine, for the second part substract 180 from all values. 
tempa = [temptimes(find(temptimes < 360/2)); temptimes(find(temptimes > 360/2))-180];
tempa = sort(tempa);

% b = take vector and add 180 to all values
% take a and b [a b] as a new vector, this is the end vector to plot, which
% should have identical halfs
timesCorrected = [tempa; tempa+180];