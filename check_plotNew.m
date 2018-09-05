
clc;
clear all;

%dataName={'信号发生器原始数据','信号发生器原始数据P波缺失','信号发生器原始数据R波缺失','信号发生器原始数据T波缺失','自采原始数据','自采原始数据P波缺失','自采原始数据R波缺失','自采原始数据T波缺失'}; %自采原始数据，信号发生器原始数据
dataName='自采原始数据'; 


PATH=strcat('C:\Users\User\Desktop\2016-12-14\高斯混合模型\new Gmm\实验结果分析\',dataName,'\');
aaa=dir(fullfile(PATH,'*.mat'));

%% 挑选数据
D=cell(1,length(aaa));
for ii=1:length(aaa)
   load(fullfile(PATH,aaa(ii).name));
   %Name=aaa(ii).name(1:10);% 提取运行的文件名字  例Data28  
   Nameall=aaa(ii).name;
   [n,~]=size(MsingleWave_selet);
   figure(ii)
   for i=1:n
     plot(MsingleWave_selet(i,:));
     hold on
   end

end


disp('Test Completed !');