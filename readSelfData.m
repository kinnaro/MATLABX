clc;
clear all;
%7149������
path='S:\a\a1\';
% path='P:\Matlabx\��������\';
SelfData=dir(fullfile(path,'*.txt'));
b=1;
SelfData1=dir(fullfile(path,'*.txt'));
% SelfData_test=dir(fullfile(path,'*.txt'));
for ii=1:length(SelfData)
    load(fullfile(path,SelfData(ii).name));
    %     Name=SelfData(ii).name();% ��ȡ���е��ļ�����  ��Data28
    Nameall=SelfData(ii).name;
    indlas=strfind(Nameall,'.');
    Name=Nameall(1:indlas-1);
    %saveTrainName=strcat(Name,'_train');
    %save (saveTrainName,'matrix_train') ;
    
    dataWave=eval(['X',Name,'(:,:)',';']);
    [n,~]=size(dataWave);
    %     figure(ii);
    %     for i=1:n
    %         plot(dataWave(i,:));
    %         hold on
    %     end
    for i=1:n
        plot(dataWave(i,:),'LineWidth',5);
        set(gca,'xtick',[],'ytick',[],'xcolor','b','ycolor','b')
        set(gcf,'color',[1 1 1]) %���ñ���ɫΪ��ɫ title('����ͼ�񱣴�')
        F=getframe();
        imwrite(F.cdata,['S:\a\a1\','V',Name,'-',int2str(i),'.jpg'])
    end
    dataWave=[];
end
