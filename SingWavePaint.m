clear all
clc
% cd('E:\������\MatLab\����\����������ͼ');
cd('S:\����ʵ��\�õ���V');
% Swenjian=dir('E:\������\MatLab\����\��������\*.mat');
Swenjian=dir('S:\����ʵ��\�õ���V\*.csv');
for a=1:161
%      load(['E:\������\MatLab\����\��������\',Swenjian(a).name]);
     load(['S:\����ʵ��\�õ���V\',Swenjian(a).name]);
     sname=Swenjian(a).name(1:3);
     sname1=Swenjian(a).name(1:3);
     folderName{a}=sname;
     mkdir(folderName{a});
     SingleWave = test_04_17;
     [row,col]=size(SingleWave);
     for b=1:row
         c=SingleWave(b,:);
         plot(c,'LineWidth',6);
         set(gca,'xtick',[],'ytick',[],'xcolor','w','ycolor','w')
         set(gcf,'color',[1 1 1]) %���ñ���ɫΪ��ɫ title('����ͼ�񱣴�') 
         %set( linehandle, 'linesmoothing', 'on' )F1=getframe;     % ��ȡ������Ϊ���ͼ��  
         F=getframe();
         %imwrite(F.cdata,['E:\MatLab\test\223\',int2str(i),'.jpg'])
         imwrite(F.cdata,['S:\����ʵ��\����NV\����V\��ͼ\',sname,'\',sname1,'-',int2str(b),'.jpg'])
     end
end
