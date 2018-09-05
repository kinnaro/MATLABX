clear all
clc
% x=xlsread('P:\Matlabx\测试数据\JF3-2.csv');
PATH= 'P:\Matlabx\测试数据\FLL1-1.csv';  %样本路径
x=importdata(PATH);  %导入数据
fs=250;
n = length (x) ;
n1=0:n-1;
t=0:1/fs:(length(x)-1)/fs;
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
 
%用汉明窗设计带通滤波器
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
subplot(2,1,1);plot(t,yb);title('滤波后的信号波形');
xlabel('time/s');ylabel('Amplitude');%axis([0 35 -500 500]);
subplot(2,1,2);plot(fx(1:n/2),YB1(1:n/2));title('滤波后的信号频谱');
xlabel('Frequence/Hz');ylabel('Amplitude');%axis([0 500 0 150000]);
%axis([0 2.5e4 0 600]);