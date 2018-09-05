clc;
clear all;
%7149个室早
path='S:\a\a1\';
% path='P:\Matlabx\测试数据\';
SelfData=dir(fullfile(path,'*.txt'));
b=1;
SelfData1=dir(fullfile(path,'*.txt'));
% SelfData_test=dir(fullfile(path,'*.txt'));
for ii=1:length(SelfData)
    load(fullfile(path,SelfData(ii).name));
    %     Name=SelfData(ii).name();% 提取运行的文件名字  例Data28
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
        set(gcf,'color',[1 1 1]) %设置背景色为白色 title('测试图像保存')
        F=getframe();
        imwrite(F.cdata,['S:\a\a1\','V',Name,'-',int2str(i),'.jpg'])
    end
    dataWave=[];
end
