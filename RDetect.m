clear;
level=4;
sr=250; %样本数据的采样率

PATH= '102_1.txt';  %样本路径
points=5000;   %一次处理的采样点数目
ecgdata=importdata(PATH);  %导入数据
swa=zeros(4,points);%存储概貌信息
swd=zeros(4,points);%存储细节信息
signal=ecgdata(1*points+1:2*points); %取点信号
%算小波系数和尺度系数
%低通滤波器 1/4 3/4 3/4 1/4
%高通滤波器 -1/4 -3/4 3/4 1/4
%二进样条小波
for i=1:points-3
    swa(1,i+3)=1/4*signal(i+3-2^0*0)+3/4*signal(i+3-2^0*1)+3/4*signal(i+3-2^0*2)+1/4*signal(i+3-2^0*3);
    swd(1,i+3)=-1/4*signal(i+3-2^0*0)-3/4*signal(i+3-2^0*1)+3/4*signal(i+3-2^0*2)+1/4*signal(i+3-2^0*3);
end
j=2;
while j<=level
    for i=1:points-24
        swa(j,i+24)=1/4*swa(j-1,i+24-2^(j-1)*0)+3/4*swa(j-1,i+24-2^(j-1)*1)+3/4*swa(j-1,i+24-2^(j-1)*2)+1/4*swa(j-1,i+24-2^(j-1)*3);
        swd(j,i+24)=-1/4*swa(j-1,i+24-2^(j-1)*0)-3/4*swa(j-1,i+24-2^(j-1)*1)+3/4*swa(j-1,i+24-2^(j-1)*2)+1/4*swa(j-1,i+24-2^(j-1)*3);
    end
    j=j+1;
end

%画出原信号和尺度系数，小波系数
% figure(10);
% subplot(level+1,1,1);plot(ecgdata(1:points));grid on ;axis tight;
% title('ECG信号在j=1,2,3,4尺度下的尺度系数对比');
% for i=1:level
%    subplot(level+1,1,i+1);
%    plot(swa(i,:));axis tight;grid on; xlabel('time');ylabel(strcat('a  ',num2str(i)));
% end
% figure(11);
% subplot(level,1,1); plot(ecgdata(1:points)); grid on;axis tight;
% title('ECG信号及其在j=1,2,3,4尺度下的尺度系数及小波系数');
% for i=1:level
%    subplot(level+1,2,2*(i)+1);
%    plot(swa(i,:)); axis tight;grid on;xlabel('time');
%    ylabel(strcat('a   ',num2str(i)));
%    subplot(level+1,2,2*(i)+2);
%    plot(swd(i,:)); axis tight;grid on;
%    ylabel(strcat('d   ',num2str(i)));
% end

%画出原图及小波系数
% figure(12);
% subplot(level,1,1); plot(real(ecgdata(1:points)),'b'); grid on;axis tight;
% title('ECG信号及其在j=1,2,3,4尺度下的小波系数');
% for i=1:level
%    subplot(level+1,1,i+1);
%    plot(swd(i,:),'b'); axis tight;grid on;
%    ylabel(strcat('d   ',num2str(i)));
% end

%**************************************求正负极大值对**********************%
ddw=zeros(size(swd));
pddw=ddw;
nddw=ddw;
%小波系数的大于0的点
posw=swd.*(swd>0);
%斜率大于0
pdw=((posw(:,1:points-1)-posw(:,2:points))<0);
%正极大值点
pddw(:,2:points-1)=((pdw(:,1:points-2)-pdw(:,2:points-1))>0);
%小波系数小于0的点
negw=swd.*(swd<0);
ndw=((negw(:,1:points-1)-negw(:,2:points))>0);
%负极大值点
nddw(:,2:points-1)=((ndw(:,1:points-2)-ndw(:,2:points-1))>0);
%或运算
ddw=pddw|nddw;
ddw(:,1)=1;
ddw(:,points)=1;
%求出极值点的值,其他点置0
wpeak=ddw.*swd;
wpeak(:,1)=wpeak(:,1)+1e-10;
wpeak(:,points)=wpeak(:,points)+1e-10;

%画出各尺度下极值点
figure(13);
for i=1:level
    subplot(level,1,i);
    plot(wpeak(i,:)); axis tight;grid on;
    ylabel(strcat('j=   ',num2str(i)));
end
subplot(4,1,1);
title('ECG信号在j=1,2,3,4尺度下的小波系数的模极大值点');

interva2=zeros(1,points);
intervaqs=zeros(1,points);
Mj1=wpeak(1,:);
Mj3=wpeak(3,:);
Mj4=wpeak(4,:);
%画出尺度3极值点
figure(14);
plot (Mj3);
title('尺度3下小波系数的模极大值点');
posi=Mj3.*(Mj3>0);
%求正极大值的平均
thposi=(max(posi(1:round(points/4)))+max(posi(round(points/4):2*round(points/4)))+max(posi(2*round(points/4):3*round(points/4)))+max(posi(3*round(points/4):4*round(points/4))))/4;
posi=(posi>thposi/3);
nega=Mj3.*(Mj3<0);
%求负极大值的平均
thnega=(min(nega(1:round(points/4)))+min(nega(round(points/4):2*round(points/4)))+min(nega(2*round(points/4):3*round(points/4)))+min(nega(3*round(points/4):4*round(points/4))))/4;
nega=-1*(nega<thnega/4);
%找出非0点
interva=posi+nega;
loca=find(interva);
for i=1:length(loca)-1
    if abs(loca(i)-loca(i+1))<80
        diff(i)=interva(loca(i))-interva(loca(i+1));
    else
        diff(i)=0;
    end
end
%找出极值对
loca2=find(diff==-2);
%负极大值点
interva2(loca(loca2(1:length(loca2))))=interva(loca(loca2(1:length(loca2))));
%正极大值点
interva2(loca(loca2(1:length(loca2))+1))=interva(loca(loca2(1:length(loca2))+1));
intervaqs(1:points-10)=interva2(11:points);
countR=zeros(1,1);
countQ=zeros(1,1);
countS=zeros(1,1);
i=1;
j=1;
Rnum=0;
%*************************求正负极值对过零，即R波峰值，并检测出QRS波起点及终点*******************%
while i<points
    if interva2(i)==-1
        mark1=i;
        i=i+1;
        while(i<points&interva2(i)==0)
            i=i+1;
        end
        mark2=i;
        %求极大值对的过零点
        mark3= round((abs(Mj3(mark2))*mark1+mark2*abs(Mj3(mark1)))/(abs(Mj3(mark2))+abs(Mj3(mark1))));
        %R波极大值点
        R_result(j)=mark3-10;%为何-10？经验值吧
        countR(mark3-10)=1;
        %求出QRS波起点
        kqs=mark3-10;
        markq=0;
        while (kqs>1)&&( markq< 3)
            if Mj1(kqs)~=0
                markq=markq+1;
            end
            kqs= kqs -1;
        end
        countQ(kqs)=-1;
        
        %求出QRS波终点
        kqs=mark3-10;
        marks=0;
        while (kqs<points)&&( marks<2)
            if Mj1(kqs)~=0
                marks=marks+1;
            end
            kqs= kqs+1;
        end
        countS(kqs)=-1;
        i=i+60;
        j=j+1;
        Rnum=Rnum+1;
    end
    i=i+1;
end


%************************删除多检点，补偿漏检点**************************%
num2=1;
while(num2~=0)
    num2=0;
    %j=3,过零点
    R=find(countR);
    %过零点间隔
    R_R=R(2:length(R))-R(1:length(R)-1);
    RRmean=mean(R_R);
    %当两个R波间隔小于0.4RRmean时,去掉值小的R波
    for i=2:length(R)
        if (R(i)-R(i-1))<=0.4*RRmean
            num2=num2+1;
            if signal(R(i))>signal(R(i-1))
                countR(R(i-1))=0;
            else
                countR(R(i))=0;
            end
        end
    end
end

num1=2;
while(num1>0)
    num1=num1-1;
    R=find(countR);
    R_R=R(2:length(R))-R(1:length(R)-1);
    RRmean=mean(R_R);
    %当发现R波间隔大于1.6RRmean时,减小阈值,在这一段检测R波
    for i=2:length(R)
        if (R(i)-R(i-1))>1.6*RRmean
            Mjadjust=wpeak(4,R(i-1)+80:R(i)-80);
            points2=(R(i)-80)-(R(i-1)+80)+1;
            %求正极大值点
            adjustposi=Mjadjust.*(Mjadjust>0);
            adjustposi=(adjustposi>thposi/4);
            %求负极大值点
            adjustnega=Mjadjust.*(Mjadjust<0);
            adjustnega=-1*(adjustnega<thnega/5);
            %或运算
            interva4=adjustposi+adjustnega;
            %找出非0点
            loca3=find(interva4);
            diff2=interva4(loca3(1:length(loca3)-1))-interva4(loca3(2:length(loca3)));
            %如果有极大值对,找出极大值对
            loca4=find(diff2==-2);
            interva3=zeros(points2,1)';
            for j=1:length(loca4)
                interva3(loca3(loca4(j)))=interva4(loca3(loca4(j)));
                interva3(loca3(loca4(j)+1))=interva4(loca3(loca4(j)+1));
            end
            mark4=0;
            mark5=0;
            mark6=0;
            while j<points2
                if interva3(j)==-1;
                    mark4=j;
                    j=j+1;
                    while(j<points2&interva3(j)==0)
                        j=j+1;
                    end
                    mark5=j;
                    %求过零点
                    mark6= round((abs(Mjadjust(mark5))*mark4+mark5*abs(Mjadjust(mark4)))/(abs(Mjadjust(mark5))+abs(Mjadjust(mark4))));
                    countR(R(i-1)+80+mark6-10)=1;
                    j=j+60;
                end
                j=j+1;
            end
        end
    end
end
%画出原图及标出检测结果
%%%%%%%%%%%%%%%%%%%%%%%%%%开始求PT波段
%对R波点前的波用加窗法，窗口大小为50，然后计算窗口内极大极小的距离
%figure(20);
%plot(Mj4);
%title('j=4 细节系数'); hold on
%%%%%%%还是直接求j=4时的R过零点吧
Mj4posi=Mj4.*(Mj4>0);
%求正极大值的平均
Mj4thposi=(max(Mj4posi(1:round(points/4)))+max(Mj4posi(round(points/4):2*round(points/4)))+max(Mj4posi(2*round(points/4):3*round(points/4)))+max(Mj4posi(3*round(points/4):4*round(points/4))))/4;
Mj4posi=(Mj4posi>Mj4thposi/3);
Mj4nega=Mj4.*(Mj4<0);
%求负极大值的平均
Mj4thnega=(min(Mj4nega(1:round(points/4)))+min(Mj4nega(round(points/4):2*round(points/4)))+min(Mj4nega(2*round(points/4):3*round(points/4)))+min(Mj4nega(3*round(points/4):4*round(points/4))))/4;
Mj4nega=-1*(Mj4nega<Mj4thnega/4);
Mj4interval=Mj4posi+Mj4nega;
Mj4local=find(Mj4interval);
Mj4interva2=zeros(1,points);
for i=1:length(Mj4local)-1
    if abs(Mj4local(i)-Mj4local(i+1))<80
        Mj4diff(i)=Mj4interval(Mj4local(i))-Mj4interval(Mj4local(i+1));
    else
        Mj4diff(i)=0;
    end
end
%找出极值对
Mj4local2=find(Mj4diff==-2);
%负极大值点
Mj4interva2(Mj4local(Mj4local2(1:length(Mj4local2))))=Mj4interval(Mj4local(Mj4local2(1:length(Mj4local2))));
%正极大值点
Mj4interva2(Mj4local(Mj4local2(1:length(Mj4local2))+1))=Mj4interval(Mj4local(Mj4local2(1:length(Mj4local2))+1));
mark1=0;
mark2=0;
mark3=0;
Mj4countR=zeros(1,1);
Mj4countQ=zeros(1,1);
Mj4countS=zeros(1,1);
flag=0;
while i<points
    if Mj4interva2(i)==-1
        mark1=i;
        i=i+1;
        while(i<points&&Mj4interva2(i)==0)
            i=i+1;
        end
        mark2=i;
        %求极大值对的过零点,在R4中极值之间过零点就是R点。
        mark3= round((abs(Mj4(mark2))*mark1+mark2*abs(Mj4(mark1)))/(abs(Mj4(mark2))+abs(Mj4(mark1))));
        Mj4countR(mark3)=1;
        Mj4countQ(mark1)=-1;
        Mj4countS(mark2)=-1;
        flag=1;
    end
    if flag==1
        i=i+60;
        flag=0;
    else
        i=i+1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%找到MJ4的QRS点后，这里缺少对R点的漏点检测和冗余检测，先不去细究了。
%%%%%
%%%%%对尺度4下R点检测不够好，需要改进的地方
%%%%%%

% figure(200);
% plot(Mj4);
% hold on ;
% plot(ecgdata(0*points+1:1*points),'r');
% title('j=4');
% hold on;
% plot(Mj4countR,'r');
% plot(Mj4countQ,'g');
% plot(Mj4countS,'y');

%%%%%%%%%%%%%%%%%%%%%%%%%% Mj4过零点找到 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rlocated=find(Mj4countR);
% Qlocated=find(Mj4countQ);
% Slocated=find(Mj4countS);
% countPMj4=zeros(1,1);
% countTMj4=zeros(1,1);
% countP=zeros(1,1);
% countPbegin=zeros(1,1);
% countPend=zeros(1,1);
% countT=zeros(1,1);
% countTbegin = zeros(1,1);
% countTend = zeros(1,1);
% % windowSize=50;%MIT-BIH Arrhythmia DB里面windowSize的值是50
% windowSize=50;


figure('NumberTitle', 'off', 'Name', PATH);
maxecgdata = max(abs(ecgdata)) ;%求出原始数据里面的最大绝对值
ecgdata=ecgdata./maxecgdata;  %把所有值都缩小在-1和1之间

%绘制心电波形

plot(ecgdata(1*points+1:2*points));
title('ECG信号的各波波段检测');
hold on
plot(countR,'r');  %画出自动识别的R点位置
%plot(countQ,'k'); %画出自动识别的Q点位置
%plot(countS,'k');   %画出自动识别的S点位置

for x=1:Rnum
    if R_result(x)==0; %画出R点
        break
    end
    plot(R_result(x),ecgdata(R_result(x)),'bo','MarkerSize',10,'MarkerEdgeColor','g');  %画出R点，用绿色的圆圈表示出来
end




