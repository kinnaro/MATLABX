close all; clear; clc;
str='S:\ThreeTime\train_Data_NVLRA_CNN_gray\A\';
strAll='*jpg';
path=strcat(str,strAll);
file=dir(path);
num=length(file);
for a=1:length(file)
disp(a);
ImgPath=strcat(str,file(a).name);
MyYuanLaiPic = imread(ImgPath);%��ȡRGB��ʽ��ͼ��  
MyFirstGrayPic = rgb2gray(MyYuanLaiPic);%�����еĺ�������RGB���Ҷ�ͼ���ת��  
  
[rows , cols , colors] = size(MyYuanLaiPic);%�õ�ԭ��ͼ��ľ���Ĳ���  
MidGrayPic = zeros(rows , cols);%�õõ��Ĳ�������һ��ȫ��ľ���������������洢������ķ��������ĻҶ�ͼ��  
MidGrayPic = uint8(MidGrayPic);%��������ȫ�����ת��Ϊuint8��ʽ����Ϊ���������䴴��֮��ͼ����double�͵�  
  
for i = 1:rows  
    for j = 1:cols  
        sum = 0;  
        for k = 1:colors  
            sum = sum + MyYuanLaiPic(i , j , k) / 3;%����ת���Ĺؼ���ʽ��sumÿ�ζ���Ϊ��������ֶ����ܳ���255  
        end  
        MidGrayPic(i , j) = sum;  
    end   
end  
imwrite(MidGrayPic , ImgPath , 'jpg');  
end