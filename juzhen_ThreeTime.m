clear all;
close all; clear; clc;
str='S:\ThreeTime\train_Data_NVLRA_CNN_gray\train_NVLRA\';
strAll='*.jpg';
path=strcat(str,strAll);
file=dir(path);
num=length(file);
B=zeros(num,1024);
D=zeros(num,5);
% length = length(file);
for i=1:length(file)
    ImgPath=strcat(str,file(i).name);
    b=imread(ImgPath);
    in=reshape(b,1,1024);
    B(i,:)=255-in;
    if(i>0&&i<3601)
        D(i,1)=1;
    elseif(i>3600&&i<7201)
        D(i,2)=1;
    elseif(i>7200&&i<10801)
        D(i,3)=1;
    elseif(i>10800&&i<14401)
        D(i,4)=1;
    elseif(i>14400&&i<16651)
        D(i,5)=1;
%     elseif(i>1200&&i<1401)
%         D(i,7)=1;
%     elseif(i>1400&&i<1601)
%         D(i,8)=1;
%     elseif(i>1600&&i<1801)
%         D(i,9)=1;
%     else
%         D(i,10)=1;
%     elseif(i>1800&&i<2001)
%         D(i,10)=1;
%     elseif(i>2000&&i<2201)
%         D(i,11)=1;
%     elseif(i>2200&&i<2401)
%         D(i,12)=1;
%     elseif(i>2400&&i<2601)
%         D(i,13)=1;
%     elseif(i>2600&&i<2801)
%         D(i,14)=1;
%     elseif(i>2800&&i<3001)
%         D(i,15)=1;
%     elseif(i>3000&&i<3201)
%         D(i,16)=1;
%     elseif(i>3200&&i<3401)
%         D(i,17)=1;
%     elseif(i>3400&&i<3601)
%         D(i,18)=1;
%     elseif(i>3600&&i<3801)
%         D(i,19)=1;
%     elseif(i>3800&&i<4001)
%         D(i,20)=1;
%     elseif(i>4000&&i<4201)
%         D(i,21)=1;
%     elseif(i>4200&&i<4401)
%         D(i,22)=1;
%     elseif(i>4400&&i<4601)
%         D(i,23)=1;
%     elseif(i>4600&&i<4801)
%         D(i,24)=1;
%     else
%         D(i,25)=1;
% %     elseif(i>25000&&i<26001)
% %         D(i,26)=1;
% %     elseif(i>26000&&i<27001)
% %         D(i,27)=1;
%     else
%         D(i,28)=1;
    end
   
end
train_x=uint8(B);
train_y=uint8(D);
%此处是转换测试数据
str2='S:\ThreeTime\train_Data_NVLRA_CNN_gray\test_NVLRA\';
strAll='*.jpg';
path2=strcat(str2,strAll);
file2=dir(path2);
num2=length(file2);
G=zeros(num2,1024);
h=zeros(num2,5);
for k=1:length(file2)
    ImgPath2=strcat(str2,file2(k).name);
    c=imread(ImgPath2);
    in=reshape(c,1,1024);
     G(k,:)=255-in;
     if(k>0&&k<401)
        h(k,1)=1;
    elseif(k>400&&k<801)
         h(k,2)=1;
    elseif(k>800&&k<1201)
        h(k,3)=1;
    elseif(k>1200&&k<1601)
        h(k,4)=1;
    elseif(k>1600&&k<1851)
        h(k,5)=1;
%     elseif(k>3000&&k<3501)
%         h(k,7)=1;
%     elseif(k>3500&&k<4001)
%         h(k,8)=1;
%     elseif(k>4000&&k<4501)
%         h(k,9)=1;
%     elseif(k>4500&&k<5001)
%         h(k,10)=1;
%     elseif(k>5000&&k<5501)
%         h(k,11)=1;
%     elseif(k>5500&&k<6001)
%         h(k,12)=1;
%     elseif(k>6000&&k<6501)
%         h(k,13)=1;
%     elseif(k>6500&&k<7001)
%         h(k,14)=1;
%     elseif(k>7000&&k<7501)
%         h(k,15)=1;
%     elseif(k>7500&&k<8001)
%         h(k,16)=1;
%     elseif(k>8000&&k<8501)
%         h(k,17)=1;
%     elseif(k>8500&&k<9001)
%         h(k,18)=1;
%     elseif(k>9000&&k<9501)
%         h(k,19)=1;
%     elseif(k>9500&&k<10001)
%         h(k,20)=1;
%     elseif(k>10000&&k<10501)
%         h(k,21)=1;
%     elseif(k>10500&&k<11001)
%         h(k,22)=1;
%     elseif(k>11000&&k<11501)
%         h(k,23)=1;
%     elseif(k>11500&&k<12001)
%         h(k,24)=1;
%      else
%          h(k,25)=1;
%     elseif(k>4800&&k<5001)
%         h(k,25)=1;
%     elseif(k>5000&&k<5201)
%         h(k,26)=1;
%     elseif(k>5200&&k<5401)
%         h(k,27)=1;
%     else
%         h(k,28)=1;
     end
end

test_x=uint8(G);
test_y=uint8(h);
save ThreeTime_CNN_NVLRA;