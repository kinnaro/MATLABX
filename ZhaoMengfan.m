clear;clc;    
        
SOURCE_PATH_t = 'S:\MIT相关文件\MIT数据采样点\正常单波后180\画图粗6 - 挑选 - 副本\';%源文件目录    
DST_PATH_t = 'S:\INPUT\不能动\随机挑选后的N1000\';%目的文件目录    
wenjian=dir('S:\MIT相关文件\MIT数据采样点\正常单波后180\画图粗6 - 挑选 - 副本\*.jpg');   
% randperm(100,3) % 100里挑3条
R=randperm(67504,1000); % 100里挑3条
for i=1:1000    
  
  filename=strcat('S:\MIT相关文件\MIT数据采样点\正常单波后180\画图粗6 - 挑选 - 副本\',wenjian(R(1,i)).name);    
     
  movefile(filename,DST_PATH_t);   
end