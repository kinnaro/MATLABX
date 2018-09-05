% ģ�Ͷ�
% ��RR�����������뵽��������
clear all
clc
% ��������
load('S:\����ʵ��\train_Data_200.csv');

x_train = train_Data_200;
X11=x_train(1:5000,2:201);   % ���Ų���5000
X11=X11';
X22=x_train(5001:10000,2:201);  % ���粨��5000
X22=X22';


X111=X11(:,1:4000);     % Nȡ4000��ѵ��
X112=X11(:,4001:5000);  % Nȡ1000������


X221=X22(:,1:4000);     % Vȡ4000��ѵ��
X222=X22(:,4001:5000);  % Vȡ1000������


X=[X111 X221];    % ѵ����:һ��Ϊһ������
XX=[X112 X222] ;  % ���Լ�:һ��Ϊһ������

%=======================================================
X11R=x_train(1:5000,202:204);   % ���Ų���5000
X11R=X11R';
X22R=x_train(5001:10000,202:204);  % ���粨��5000
X22R=X22R';
X111R=X11R(:,1:4000);     % Nȡ4000��ѵ��
X112R=X11R(:,4001:5000);  % Nȡ1000������
X221R=X22R(:,1:4000);     % Vȡ4000��ѵ��
X222R=X22R(:,4001:5000);  % Vȡ1000������
XR=[X111R X221R];   % ѵ����
XXR=[X112R X222R] ;  % ���Լ�:һ��Ϊһ������

%=======================================================

% ����ѵ������ǩ 00 01
y1=zeros(2,8000);
for i=4001:8000
    y1(2,i)=1;
end


% �����������
setdemorandstream(pi)

FlattenedData = X(:)'; % չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
MappedFlattened = mapminmax(FlattenedData, 0, 1); % ��һ����
X = reshape(MappedFlattened, size(X)); % ��ԭΪԭʼ������ʽ���˴�����ת�û�ȥ����Ϊreshapeǡ���ǰ�����������
X = [X;XR]; % ѵ��ǰ����R�������253ά*8000����
%%%%%%%%%%%%%%%%%%%%%
%%%% ���������� %%%%
%%%%%%%%%%%%%%%%%%%%%
net=newff(minmax(X),[23,2],{'tansig','purelin'},'trainlm');
net.trainParam.show=10; %����������ʾˢ��Ƶ�ʣ�ѧϰ��ˢ��һ��ͼ��
net.trainParam.epochs=1000; %��� ѵ������
net.trainParam.goal=3e-4; % ����ѵ�����
net=init(net);%�����ʼ��
[net, tr]=train(net,X,y1);%ѵ������
disp('BP������ѵ����ɣ�');

FlattenedData1 = XX(:)'; % չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
MappedFlattened1 = mapminmax(FlattenedData1, 0, 1); % ��һ����
XX = reshape(MappedFlattened1, size(XX)); % ��ԭΪԭʼ������ʽ���˴�����ת�û�ȥ����Ϊreshapeǡ���ǰ�����������
XX = [XX;XXR]; % ����ǰ����R�������253ά*8000����
result_test1 = sim(net,XX);%������������
result_test = result_test1;
result_test( result_test>0.55)=1;
result_test( result_test<=0.55)=0;
disp('�������:')
result_test;

t1=zeros(1,1000);
t2=ones(1,1000);

pp_lab=[t1 t2]; % ����������ǩ����ȷ���
res = vec2ind(result_test)-1; % ����ֵ������ֵ
strr = cell(1,2000);
kk=0;
for i=1:2000
    if res(i) == pp_lab(i)
        strr{i} = '0'; % ���� = ��ǩ
        kk=kk+1;
    else
        strr{i} = '1'; % ���� != ��ǩ
    end
end
result = strr';
acc=kk/size(pp_lab,2);
plotconfusion(pp_lab, res);
disp('Ԥ����ɣ�');
