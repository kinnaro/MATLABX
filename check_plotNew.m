
clc;
clear all;

%dataName={'�źŷ�����ԭʼ����','�źŷ�����ԭʼ����P��ȱʧ','�źŷ�����ԭʼ����R��ȱʧ','�źŷ�����ԭʼ����T��ȱʧ','�Բ�ԭʼ����','�Բ�ԭʼ����P��ȱʧ','�Բ�ԭʼ����R��ȱʧ','�Բ�ԭʼ����T��ȱʧ'}; %�Բ�ԭʼ���ݣ��źŷ�����ԭʼ����
dataName='�Բ�ԭʼ����'; 


PATH=strcat('C:\Users\User\Desktop\2016-12-14\��˹���ģ��\new Gmm\ʵ��������\',dataName,'\');
aaa=dir(fullfile(PATH,'*.mat'));

%% ��ѡ����
D=cell(1,length(aaa));
for ii=1:length(aaa)
   load(fullfile(PATH,aaa(ii).name));
   %Name=aaa(ii).name(1:10);% ��ȡ���е��ļ�����  ��Data28  
   Nameall=aaa(ii).name;
   [n,~]=size(MsingleWave_selet);
   figure(ii)
   for i=1:n
     plot(MsingleWave_selet(i,:));
     hold on
   end

end


disp('Test Completed !');