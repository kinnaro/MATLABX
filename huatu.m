clear all
clc

T = readtable('S:\ThreeTime\�����ѡ��NVARL\���4000\���all_A.csv','ReadVariableNames',false);
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
    set(gcf,'color',[1 1 1]) %���ñ���ɫΪ��ɫ title('����ͼ�񱣴�')
    F=getframe();
    imwrite(F.cdata,['S:\ThreeTime\�����ѡ��NVARL\���4000\A\',sname{b},'.jpg'])
%     imwrite(F.cdata,['S:\����ʵ��\train_Data_NVLRA_CNN\',sname(b),'.jpg'])
    s = [];
end