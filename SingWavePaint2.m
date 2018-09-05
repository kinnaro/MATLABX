clear all
clc
% cd('E:\姬生振\MatLab\房颤\房颤单波画图');
cd('S:\BPData\1');
% Swenjian=dir('E:\姬生振\MatLab\房颤\房颤单波\*.mat');
Swenjian=dir('S:\BPData\1\*.csv');
for a=1:161
%      load(['E:\姬生振\MatLab\房颤\房颤单波\',Swenjian(a).name]);
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
         set(gcf,'color',[1 1 1]) %设置背景色为白色 title('测试图像保存') 
         %set( linehandle, 'linesmoothing', 'on' )F1=getframe;     % 获取坐标轴为界的图像  
         F=getframe();
         %imwrite(F.cdata,['E:\MatLab\test\223\',int2str(i),'.jpg'])
%          imwrite(F.cdata,['S:\BPData\1\画图\',sname,'\',sname1,'-',int2str(b),'.jpg'])
        imwrite(F.cdata,['S:\BPData\1\train\',int2str(b),'.jpg'])
     end
end
