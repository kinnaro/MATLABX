clear all
clc

T = readtable('S:\ThreeTime\随机挑选的NVARL\随机4000\随机all_A.csv','ReadVariableNames',false);
s = [];
% sname=T.Var1;
sname=(1:2500)';
sname = sprintfc('%g',sname);
SingleWave = T;
[row,col]=size(SingleWave);
i = 1;
for b=1:row
    c=SingleWave(b,2:201);
    s = table2array(c);
    plot(s,'LineWidth',6);
    set(gca,'xtick',[],'ytick',[],'xcolor','w','ycolor','w')
    set(gcf,'color',[1 1 1]) %设置背景色为白色 title('测试图像保存')
    F=getframe();
    imwrite(F.cdata,['S:\ThreeTime\随机挑选的NVARL\随机4000\A\',sname{b},'.jpg'])
%     imwrite(F.cdata,['S:\三次实验\train_Data_NVLRA_CNN\',sname(b),'.jpg'])
    s = [];
end