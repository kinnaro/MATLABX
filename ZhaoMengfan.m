clear;clc;    
        
SOURCE_PATH_t = 'S:\MIT����ļ�\MIT���ݲ�����\����������180\��ͼ��6 - ��ѡ - ����\';%Դ�ļ�Ŀ¼    
DST_PATH_t = 'S:\INPUT\���ܶ�\�����ѡ���N1000\';%Ŀ���ļ�Ŀ¼    
wenjian=dir('S:\MIT����ļ�\MIT���ݲ�����\����������180\��ͼ��6 - ��ѡ - ����\*.jpg');   
% randperm(100,3) % 100����3��
R=randperm(67504,1000); % 100����3��
for i=1:1000    
  
  filename=strcat('S:\MIT����ļ�\MIT���ݲ�����\����������180\��ͼ��6 - ��ѡ - ����\',wenjian(R(1,i)).name);    
     
  movefile(filename,DST_PATH_t);   
end