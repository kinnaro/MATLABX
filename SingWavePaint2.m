clear all
clc
% cd('E:\������\MatLab\����\����������ͼ');
cd('S:\BPData\1');
% Swenjian=dir('E:\������\MatLab\����\��������\*.mat');
Swenjian=dir('S:\BPData\1\*.csv');
for a=1:161
%      load(['E:\������\MatLab\����\��������\',Swenjian(a).name]);
     load(['S:\BPData\1\',Swenjian(a).name]);
     sname=Swenjian(a).name(1:3);
     sname1=Swenjian(a).name(1:3);
     folderName{a}=sname;
     mkdir(folderName{a});
     SingleWave = train_04_17;
     [row,col]=size(SingleWave);
     for b=1:row
         c=SingleWave(b,:);
         plot(c,'LineWidth',6);
         set(gca,'xtick',[],'ytick',[],'xcolor','w','ycolor','w')
         set(gcf,'color',[1 1 1]) %���ñ���ɫΪ��ɫ title('����ͼ�񱣴�') 
         %set( linehandle, 'linesmoothing', 'on' )F1=getframe;     % ��ȡ������Ϊ���ͼ��  
         F=getframe();
         %imwrite(F.cdata,['E:\MatLab\test\223\',int2str(i),'.jpg'])
%          imwrite(F.cdata,['S:\BPData\1\��ͼ\',sname,'\',sname1,'-',int2str(b),'.jpg'])
        imwrite(F.cdata,['S:\BPData\1\train\',int2str(b),'.jpg'])
     end
end
