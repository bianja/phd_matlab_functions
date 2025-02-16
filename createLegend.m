function [] = createLegend(IN,COL,TYPE,LOC,LW)
% 
% INPUT
% IN = text input for legend
% COL = needs to be in html code (triplet) and can differ for vars
% TYPE = line style (can also differ for vars)
% LOC = location of the legend (look up matlab description for legend to see possible input values)
% LW = width of lines (only one value possible, all vars have same LW value)
%
% EXAMPLE createLegend({'var1','var2'},[100 100 100; 150 150 150],{'-','-'},'best',1.5)
%
% Version 02-12-2022


if length(TYPE) ~= length(IN)
    for i = 1 : length(IN)
        TYPE(i) = TYPE(1);
    end
else
end

if sum(sum(COL > 1)) > 1
    COL = COL/255;
else
end

h = zeros(length(IN), 1);
for i = 1 : length(IN)
    h(i) = plot(0,0,char(TYPE(i)),'Color',COL(i,:));
end
% legend(h, IN, 'Location',char(LOC));
[~, hobj, ~, ~] = legend(h, IN);
hl = findobj(hobj,'type','line');
set(hl,'LineWidth',LW);