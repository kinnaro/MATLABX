clear all
clc
%*********读入数据**********
% x=xlsread('P:\Matlabx\测试数据\JF3-2.csv');
PATH= 'P:\Matlabx\测试数据\ZMF2-1.csv';  %样本路径
x=importdata(PATH);  %导入数据
fs=250;
n=length(x);
n1=0:n-1;
t=0:1/fs:(length(x)-1)/fs;
fx=fs*n1/n;
X=fft(x,n);
X1=abs(X);

%***********画图（原始信号及频谱图）*********
figure(1)
subplot(2,1,1);plot(t,x);title('原始信号');grid;
xlabel('Time(s)');ylabel('Magnitude');%axis([0 16 2500 4000]);
subplot(2,1,2);plot(fx(1:n/2),X1(1:n/2));title('原始信号频谱图');grid;
xlabel('Frequency(Hz)');ylabel('Magnitude');axis([0 500 0 150000]);

%************滤波器设计**************
fp=40;   %通带截止频率
fss=47;  %阻带截止频率
%fs=250;
wp=2*pi*fp/fs;
ws=2*pi*fss/fs;
wap=tan(wp/2);was=tan(ws/2);
Rp=1;
Rs=10;
%eps=sqrt(10^(Rp/10)-1);%%通带波动参数
% Ripple=sqrt(1/(1+ep*ep))%通带波动
% Attn=1/(10^(Rs/20))%阻带衰减
[N,Wn]=buttord(wap,was,Rp,Rs,'s');%j计算阶数N，和截止频率
[z,p,k]=buttap(N);%设计归一化的巴特沃斯模拟原型滤波器
[bp,ap]=zp2tf(z,p,k);%系统函数零极点转化系统函数般形式系数
[bs,as]=lp2lp(bp,ap,wap);%变换为模拟低通滤波器
[bz,az]=bilinear(bs,as,1/2);    %双线性变换求数字滤波器系数
[H,w]=freqz(bz,az,250,fs);
dbH=20*log10((abs(H)+eps)/max(abs(H)));

%**********画滤波器的特性图***************
figure(2)
subplot(2,2,1),plot(w,abs(H));grid;
title('Magnitude Response');
xlabel('Frequence(Hz)');ylabel('Magnitude');%axis([0 6000 0 1.2])
subplot(2,2,2),plot(w,angle(H)/pi);grid;
title('Phase Response');
xlabel('Frequence(Hz)');ylabel('Phase');
subplot(2,2,3),plot(w,dbH);grid;
title('Magnitude Response(dB)');
xlabel('Frequence(Hz)');ylabel('Magnitude/dB');

%*************滤波***************
y=filter(bz,az,x);%滤波
Y=fft(y,n);
Y1=abs(Y);

%**********画出低通滤波后的图像**********
figure(3)
subplot(2,1,1);plot(t,y);title('滤波后的信号');grid;
xlabel('Time(s)');ylabel('Magnitude');%axis([0 16 2500 4000]);
subplot(2,1,2);plot(fx(1:n/2),Y1(1:n/2));title('滤波后的频谱图');grid;
xlabel('Frequency(Hz)');ylabel('Magnitude');axis([0 500 0 150000]);


%***************滑动平均滤波*****************

    nd=length(y);
%     figure
%      plot(t,y,'r');%绘制原始曲线
%      grid
%      hold on

     col_array=nd;   %总共离散点的个数
     data_array_section=ones(1,col_array);
     for k=1:col_array
          data_array_section(k)=y(k);  %将取出的650个采样点放入矩阵data_array_section中
     end

     moving_point=7;      %?定义moving average中去多少个点进行平均运算，也就是M的值，必须为奇数;比较后最佳值9
     moving_point_left=(-moving_point+1)/2;  
     moving_point_right=(moving_point-1)/2;  %取输出点对称两边的采样点的值做平均
     data_array_filter=zeros(1,col_array);   %初始化一个和data_array_section大小相同的矩阵，存储结果
 
     for i=1:moving_point_right
          data_array_filter(i)=data_array_section(i);  
     end

     for i=(col_array+moving_point_left+1):col_array  
          data_array_filter(i)=data_array_section(i);
     end  %这一段代码，是对矩阵的前(M-1)/2个和后(M-1)/2个点进行赋值,因为这些前期和后期的点，无法由算法更新                    

     for i=(moving_point_right+1):(col_array+moving_point_left)  %i的范围为要更新的数据下标范围
          for j=moving_point_left:moving_point_right
               data_array_filter(i)=data_array_filter(i)+data_array_section(i+j);  %moving average filter process
          end
     data_array_filter(i)=data_array_filter(i)/moving_point;
     end
     figure(4)
     subplot(2,1,1);plot(t,data_array_filter);%axis([0 16 2500 4000]);%绘制滤波后的曲线
     %hold off
     %axis([0,10,-400,400]);
    % legend('bf处理后信号','bf和hp处理后信号');
%      saveas(gca,[path_in,num2str(ki)],'fig');
%      close
%      yy=data_array_filter;
%      [my,ny]=size(yy);
%      Nzbfhd(count,1:ny)=yy(1,1:ny);
%          
%      count=count+1;
%      clear t data_array data_array_filter y;