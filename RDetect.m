clear;
level=4;
sr=250; %�������ݵĲ�����

PATH= '102_1.txt';  %����·��
points=5000;   %һ�δ���Ĳ�������Ŀ
ecgdata=importdata(PATH);  %��������
swa=zeros(4,points);%�洢��ò��Ϣ
swd=zeros(4,points);%�洢ϸ����Ϣ
signal=ecgdata(1*points+1:2*points); %ȡ���ź�
%��С��ϵ���ͳ߶�ϵ��
%��ͨ�˲��� 1/4 3/4 3/4 1/4
%��ͨ�˲��� -1/4 -3/4 3/4 1/4
%��������С��
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

%����ԭ�źźͳ߶�ϵ����С��ϵ��
% figure(10);
% subplot(level+1,1,1);plot(ecgdata(1:points));grid on ;axis tight;
% title('ECG�ź���j=1,2,3,4�߶��µĳ߶�ϵ���Ա�');
% for i=1:level
%    subplot(level+1,1,i+1);
%    plot(swa(i,:));axis tight;grid on; xlabel('time');ylabel(strcat('a  ',num2str(i)));
% end
% figure(11);
% subplot(level,1,1); plot(ecgdata(1:points)); grid on;axis tight;
% title('ECG�źż�����j=1,2,3,4�߶��µĳ߶�ϵ����С��ϵ��');
% for i=1:level
%    subplot(level+1,2,2*(i)+1);
%    plot(swa(i,:)); axis tight;grid on;xlabel('time');
%    ylabel(strcat('a   ',num2str(i)));
%    subplot(level+1,2,2*(i)+2);
%    plot(swd(i,:)); axis tight;grid on;
%    ylabel(strcat('d   ',num2str(i)));
% end

%����ԭͼ��С��ϵ��
% figure(12);
% subplot(level,1,1); plot(real(ecgdata(1:points)),'b'); grid on;axis tight;
% title('ECG�źż�����j=1,2,3,4�߶��µ�С��ϵ��');
% for i=1:level
%    subplot(level+1,1,i+1);
%    plot(swd(i,:),'b'); axis tight;grid on;
%    ylabel(strcat('d   ',num2str(i)));
% end

%**************************************����������ֵ��**********************%
ddw=zeros(size(swd));
pddw=ddw;
nddw=ddw;
%С��ϵ���Ĵ���0�ĵ�
posw=swd.*(swd>0);
%б�ʴ���0
pdw=((posw(:,1:points-1)-posw(:,2:points))<0);
%������ֵ��
pddw(:,2:points-1)=((pdw(:,1:points-2)-pdw(:,2:points-1))>0);
%С��ϵ��С��0�ĵ�
negw=swd.*(swd<0);
ndw=((negw(:,1:points-1)-negw(:,2:points))>0);
%������ֵ��
nddw(:,2:points-1)=((ndw(:,1:points-2)-ndw(:,2:points-1))>0);
%������
ddw=pddw|nddw;
ddw(:,1)=1;
ddw(:,points)=1;
%�����ֵ���ֵ,��������0
wpeak=ddw.*swd;
wpeak(:,1)=wpeak(:,1)+1e-10;
wpeak(:,points)=wpeak(:,points)+1e-10;

%�������߶��¼�ֵ��
figure(13);
for i=1:level
    subplot(level,1,i);
    plot(wpeak(i,:)); axis tight;grid on;
    ylabel(strcat('j=   ',num2str(i)));
end
subplot(4,1,1);
title('ECG�ź���j=1,2,3,4�߶��µ�С��ϵ����ģ����ֵ��');

interva2=zeros(1,points);
intervaqs=zeros(1,points);
Mj1=wpeak(1,:);
Mj3=wpeak(3,:);
Mj4=wpeak(4,:);
%�����߶�3��ֵ��
figure(14);
plot (Mj3);
title('�߶�3��С��ϵ����ģ����ֵ��');
posi=Mj3.*(Mj3>0);
%��������ֵ��ƽ��
thposi=(max(posi(1:round(points/4)))+max(posi(round(points/4):2*round(points/4)))+max(posi(2*round(points/4):3*round(points/4)))+max(posi(3*round(points/4):4*round(points/4))))/4;
posi=(posi>thposi/3);
nega=Mj3.*(Mj3<0);
%�󸺼���ֵ��ƽ��
thnega=(min(nega(1:round(points/4)))+min(nega(round(points/4):2*round(points/4)))+min(nega(2*round(points/4):3*round(points/4)))+min(nega(3*round(points/4):4*round(points/4))))/4;
nega=-1*(nega<thnega/4);
%�ҳ���0��
interva=posi+nega;
loca=find(interva);
for i=1:length(loca)-1
    if abs(loca(i)-loca(i+1))<80
        diff(i)=interva(loca(i))-interva(loca(i+1));
    else
        diff(i)=0;
    end
end
%�ҳ���ֵ��
loca2=find(diff==-2);
%������ֵ��
interva2(loca(loca2(1:length(loca2))))=interva(loca(loca2(1:length(loca2))));
%������ֵ��
interva2(loca(loca2(1:length(loca2))+1))=interva(loca(loca2(1:length(loca2))+1));
intervaqs(1:points-10)=interva2(11:points);
countR=zeros(1,1);
countQ=zeros(1,1);
countS=zeros(1,1);
i=1;
j=1;
Rnum=0;
%*************************��������ֵ�Թ��㣬��R����ֵ��������QRS����㼰�յ�*******************%
while i<points
    if interva2(i)==-1
        mark1=i;
        i=i+1;
        while(i<points&interva2(i)==0)
            i=i+1;
        end
        mark2=i;
        %�󼫴�ֵ�ԵĹ����
        mark3= round((abs(Mj3(mark2))*mark1+mark2*abs(Mj3(mark1)))/(abs(Mj3(mark2))+abs(Mj3(mark1))));
        %R������ֵ��
        R_result(j)=mark3-10;%Ϊ��-10������ֵ��
        countR(mark3-10)=1;
        %���QRS�����
        kqs=mark3-10;
        markq=0;
        while (kqs>1)&&( markq< 3)
            if Mj1(kqs)~=0
                markq=markq+1;
            end
            kqs= kqs -1;
        end
        countQ(kqs)=-1;
        
        %���QRS���յ�
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


%************************ɾ�����㣬����©���**************************%
num2=1;
while(num2~=0)
    num2=0;
    %j=3,�����
    R=find(countR);
    %�������
    R_R=R(2:length(R))-R(1:length(R)-1);
    RRmean=mean(R_R);
    %������R�����С��0.4RRmeanʱ,ȥ��ֵС��R��
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
    %������R���������1.6RRmeanʱ,��С��ֵ,����һ�μ��R��
    for i=2:length(R)
        if (R(i)-R(i-1))>1.6*RRmean
            Mjadjust=wpeak(4,R(i-1)+80:R(i)-80);
            points2=(R(i)-80)-(R(i-1)+80)+1;
            %��������ֵ��
            adjustposi=Mjadjust.*(Mjadjust>0);
            adjustposi=(adjustposi>thposi/4);
            %�󸺼���ֵ��
            adjustnega=Mjadjust.*(Mjadjust<0);
            adjustnega=-1*(adjustnega<thnega/5);
            %������
            interva4=adjustposi+adjustnega;
            %�ҳ���0��
            loca3=find(interva4);
            diff2=interva4(loca3(1:length(loca3)-1))-interva4(loca3(2:length(loca3)));
            %����м���ֵ��,�ҳ�����ֵ��
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
                    %������
                    mark6= round((abs(Mjadjust(mark5))*mark4+mark5*abs(Mjadjust(mark4)))/(abs(Mjadjust(mark5))+abs(Mjadjust(mark4))));
                    countR(R(i-1)+80+mark6-10)=1;
                    j=j+60;
                end
                j=j+1;
            end
        end
    end
end
%����ԭͼ����������
%%%%%%%%%%%%%%%%%%%%%%%%%%��ʼ��PT����
%��R����ǰ�Ĳ��üӴ��������ڴ�СΪ50��Ȼ����㴰���ڼ���С�ľ���
%figure(20);
%plot(Mj4);
%title('j=4 ϸ��ϵ��'); hold on
%%%%%%%����ֱ����j=4ʱ��R������
Mj4posi=Mj4.*(Mj4>0);
%��������ֵ��ƽ��
Mj4thposi=(max(Mj4posi(1:round(points/4)))+max(Mj4posi(round(points/4):2*round(points/4)))+max(Mj4posi(2*round(points/4):3*round(points/4)))+max(Mj4posi(3*round(points/4):4*round(points/4))))/4;
Mj4posi=(Mj4posi>Mj4thposi/3);
Mj4nega=Mj4.*(Mj4<0);
%�󸺼���ֵ��ƽ��
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
%�ҳ���ֵ��
Mj4local2=find(Mj4diff==-2);
%������ֵ��
Mj4interva2(Mj4local(Mj4local2(1:length(Mj4local2))))=Mj4interval(Mj4local(Mj4local2(1:length(Mj4local2))));
%������ֵ��
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
        %�󼫴�ֵ�ԵĹ����,��R4�м�ֵ֮���������R�㡣
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
%%%%%%%%%%%%%%%%%%%%%%%%�ҵ�MJ4��QRS�������ȱ�ٶ�R���©����������⣬�Ȳ�ȥϸ���ˡ�
%%%%%
%%%%%�Գ߶�4��R���ⲻ���ã���Ҫ�Ľ��ĵط�
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

%%%%%%%%%%%%%%%%%%%%%%%%%% Mj4������ҵ� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
% % windowSize=50;%MIT-BIH Arrhythmia DB����windowSize��ֵ��50
% windowSize=50;


figure('NumberTitle', 'off', 'Name', PATH);
maxecgdata = max(abs(ecgdata)) ;%���ԭʼ���������������ֵ
ecgdata=ecgdata./maxecgdata;  %������ֵ����С��-1��1֮��

%�����ĵ粨��

plot(ecgdata(1*points+1:2*points));
title('ECG�źŵĸ������μ��');
hold on
plot(countR,'r');  %�����Զ�ʶ���R��λ��
%plot(countQ,'k'); %�����Զ�ʶ���Q��λ��
%plot(countS,'k');   %�����Զ�ʶ���S��λ��

for x=1:Rnum
    if R_result(x)==0; %����R��
        break
    end
    plot(R_result(x),ecgdata(R_result(x)),'bo','MarkerSize',10,'MarkerEdgeColor','g');  %����R�㣬����ɫ��ԲȦ��ʾ����
end




