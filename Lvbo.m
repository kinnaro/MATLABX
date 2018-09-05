clear
clc
% 本次滤波用到的是：
%     1.带通滤波；2.低通滤波；3.滑动平均滤波；
%  数据采用的是新板子所采集数据；
%  日期：2018.01
% 
% PATH= 'P:\Matlabx\测试数据\WYL1-1.csv';  %样本路径
PATH= 'S:\MIT相关文件\MIT数据采样点\SamplePoint\Txt\100_1.txt';  %样本路径
x=importdata(PATH);  %导入数据
x=x(:); %取前10000个采样点（测试效果用）
fs=360;
n = length (x);
n1=0:n-1;
t=0:1/fs:(n-1)/fs;
fx=fs*n1/n;   
X=fft(x,n);       %Fourier transform
X1=abs(X);
 
figure(1)
subplot(2,1,1);
plot(t,x);
title('原始信号');
xlabel('time/s');
ylabel('Amplitude');
subplot(2,1,2);
plot(fx(1:n/2),X1(1:n/2));
title(' 原始信号频谱图 ');
xlabel('Frequence/Hz');
ylabel('Amplitude');
axis([0 500 0 150000]); 
 
%% ***************用汉明窗设计带通滤波器******
ws1=2*pi*1/fs;
wp1=2*pi*2/fs;
wp2=2*pi*48/fs;
ws2=2*pi*49/fs;
wl=(ws1+wp1)/2;
wh=(wp2+ws2)/2;
delta_w=min((wp1-ws1),(ws2-wp2));
%delta_w=min((ws1-wp1),(ws2-wp2));
delta=0.001;
N=ceil((6.2*pi)/delta_w); 
l=0:N-1;
a=(N-1)/2;
m=l-a+eps;
hd=sin(wh*m)./(pi*m)-sin(wl*m)./(pi*m);
w=hanning(N);
h=hd.*w';
b=h;
[H,f]=freqz(b,1,512);
figure(3)
plot(f,20*log10(abs(H)))
xlabel('频率/Hz');ylabel('振幅/dB');grid on;
  
%带通滤波
a=1;
yb=filter(b,a,x);
YB=fft(yb,n);
YB1=abs(YB);
 
figure(4)
subplot(2,1,1);plot(t,yb);title('带通滤波后的信号波形');
xlabel('time/s');ylabel('Amplitude');%axis([0 35 -500 500]);
subplot(2,1,2);plot(fx(1:n/2),YB1(1:n/2));title('带通滤波后的信号频谱');
xlabel('Frequence/Hz');ylabel('Amplitude');%axis([0 500 0 150000]);
%axis([0 2.5e4 0 600]);

%% ***************滤波器设计********************
x=yb; 
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
figure(5)
subplot(2,2,1),plot(w,abs(H));grid;
title('Magnitude Response');
xlabel('Frequence(Hz)');ylabel('Magnitude');%axis([0 6000 0 1.2])
subplot(2,2,2),plot(w,angle(H)/pi);grid;
title('Phase Response');
xlabel('Frequence(Hz)');ylabel('Phase');
subplot(2,2,3),plot(w,dbH);grid;
title('Magnitude Response(dB)');
xlabel('Frequence(Hz)');ylabel('Magnitude/dB');

%% ***************低通滤波**********************
y=filter(bz,az,x);%滤波
Y=fft(y,n);
Y1=abs(Y);

%**********画出低通滤波后的图像**********
figure(6)
subplot(2,1,1);plot(t,y);title('低通滤波后的信号');grid;
xlabel('Time(s)');ylabel('Magnitude');%axis([0 16 2500 4000]);
subplot(2,1,2);plot(fx(1:n/2),Y1(1:n/2));title('低通滤波后的频谱图');grid;
xlabel('Frequency(Hz)');ylabel('Magnitude');axis([0 500 0 150000]);

%% ***************滑动平均滤波*****************

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
     figure(7)
     subplot(2,1,1);plot(t,data_array_filter);title('滑动平均滤波后的信号');grid;%axis([0 16 2500 4000]);%绘制滤波后的曲线
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