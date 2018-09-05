clear
clc

% load('S:\ThreeTime\所有NV\所有N\ThreeTimeN-有RR.csv');
% load('S:\ThreeTime\所有NV\所有V\ThreeTimeV-有RR.csv');
% X____A__RR = readtable('S:\ThreeTime\随机挑选的NVARL\随机all_A.csv');
X____R__RR = readtable('S:\ThreeTime\随机挑选的NVARL\随机all_R.csv');
X____L__RR = readtable('S:\ThreeTime\随机挑选的NVARL\随机all_L.csv');
X____N__RR = readtable('S:\ThreeTime\随机挑选的NVARL\随机all_N.csv');
X____V__RR = readtable('S:\ThreeTime\随机挑选的NVARL\随机all_V.csv');


% all_A = X____A__RR(randperm(2390, 2500),:);
all_R = X____R__RR(randperm(4943, 4000),:);
all_L = X____L__RR(randperm(4123, 4000),:);
all_N = X____N__RR(randperm(5000, 4000),:);
all_V = X____V__RR(randperm(5000, 4000),:);

% csvwrite('S:\ThreeTime\所有NV\随机all_N.csv',all_N);
% csvwrite('S:\ThreeTime\所有NV\随机all_V.csv',all_V);
% writetable(all_A,'S:\ThreeTime\随机挑选的NVARL\随机1500\随机all_A.csv','Delimiter',',','QuoteStrings',true);
writetable(all_R,'S:\ThreeTime\随机挑选的NVARL\随机4000\随机all_R.csv','Delimiter',',','QuoteStrings',true);
writetable(all_L,'S:\ThreeTime\随机挑选的NVARL\随机4000\随机all_L.csv','Delimiter',',','QuoteStrings',true);
writetable(all_N,'S:\ThreeTime\随机挑选的NVARL\随机4000\随机all_N.csv','Delimiter',',','QuoteStrings',true);
writetable(all_V,'S:\ThreeTime\随机挑选的NVARL\随机4000\随机all_V.csv','Delimiter',',','QuoteStrings',true);
