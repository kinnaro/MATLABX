clear
clc

% load('S:\ThreeTime\����NV\����N\ThreeTimeN-��RR.csv');
% load('S:\ThreeTime\����NV\����V\ThreeTimeV-��RR.csv');
% X____A__RR = readtable('S:\ThreeTime\�����ѡ��NVARL\���all_A.csv');
X____R__RR = readtable('S:\ThreeTime\�����ѡ��NVARL\���all_R.csv');
X____L__RR = readtable('S:\ThreeTime\�����ѡ��NVARL\���all_L.csv');
X____N__RR = readtable('S:\ThreeTime\�����ѡ��NVARL\���all_N.csv');
X____V__RR = readtable('S:\ThreeTime\�����ѡ��NVARL\���all_V.csv');


% all_A = X____A__RR(randperm(2390, 2500),:);
all_R = X____R__RR(randperm(4943, 4000),:);
all_L = X____L__RR(randperm(4123, 4000),:);
all_N = X____N__RR(randperm(5000, 4000),:);
all_V = X____V__RR(randperm(5000, 4000),:);

% csvwrite('S:\ThreeTime\����NV\���all_N.csv',all_N);
% csvwrite('S:\ThreeTime\����NV\���all_V.csv',all_V);
% writetable(all_A,'S:\ThreeTime\�����ѡ��NVARL\���1500\���all_A.csv','Delimiter',',','QuoteStrings',true);
writetable(all_R,'S:\ThreeTime\�����ѡ��NVARL\���4000\���all_R.csv','Delimiter',',','QuoteStrings',true);
writetable(all_L,'S:\ThreeTime\�����ѡ��NVARL\���4000\���all_L.csv','Delimiter',',','QuoteStrings',true);
writetable(all_N,'S:\ThreeTime\�����ѡ��NVARL\���4000\���all_N.csv','Delimiter',',','QuoteStrings',true);
writetable(all_V,'S:\ThreeTime\�����ѡ��NVARL\���4000\���all_V.csv','Delimiter',',','QuoteStrings',true);
