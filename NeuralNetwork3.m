% ģ����
% RR������������
clear all
clc
% ��������
load('S:\����ʵ��\����NV\train_Data.csv');

x_train = train_Data;
X11=x_train(1:5000,1:250);   % ���Ų���5000
X11=X11';
X22=x_train(5001:10000,1:250);  % ���粨��5000
X22=X22';


X111=X11(:,1:4000);     % Nȡ4000��ѵ��
X112=X11(:,4001:5000);  % Nȡ1000������


X221=X22(:,1:4000);     % Vȡ4000��ѵ��
X222=X22(:,4001:5000);  % Vȡ1000������


X=[X111 X221];    % ѵ����:һ��Ϊһ������
XX=[X112 X222] ;  % ���Լ�:һ��Ϊһ������

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

%%%%%%%%%%%%%%%%%%%%%
%%%% ���������� %%%%
%%%%%%%%%%%%%%%%%%%%%
net=newff(minmax(X),[23,2],{'tansig','purelin'},'trainlm');
net.trainParam.show=10; %����������ʾˢ��Ƶ�ʣ�ѧϰ��ˢ��һ��ͼ��
net.trainParam.epochs=1000; %��� ѵ������
net.trainParam.goal=4.5e-4; % ����ѵ�����
net=init(net);%�����ʼ��
[net, tr]=train(net,X,y1);%ѵ������
disp('BP������ѵ����ɣ�');

FlattenedData1 = XX(:)'; % չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
MappedFlattened1 = mapminmax(FlattenedData1, 0, 1); % ��һ����
XX = reshape(MappedFlattened1, size(XX)); % ��ԭΪԭʼ������ʽ���˴�����ת�û�ȥ����Ϊreshapeǡ���ǰ�����������

result_test1 = sim(net,XX);%������������
result_test = result_test1;

result_test( result_test>0.55)=1;
result_test( result_test<=0.55)=0;

disp('�������:')
result_test;
jieguo = result_test';

t1=zeros(1,1000);
t2=ones(1,1000);

pp_lab=[t1 t2]; % ����������ǩ����ȷ���
res = vec2ind(result_test)-1; % ����ֵ������ֵ
res_pre = res';
%
%
%����R-pre
X11R=x_train(1:5000,251:251);   % ���Ų���5000
X11R=X11R';
X22R=x_train(5001:10000,251:251);  % ���粨��5000
X22R=X22R';

X112R=X11R(:,4001:5000);  % Nȡ1000������

X222R=X22R(:,4001:5000);  % Vȡ1000������

XXR=[X112R X222R] ;  % ���Լ�:һ��Ϊһ������
XXR1 = XXR';
XXR(XXR<=0.6) = 0;  % 0��������
XXR(XXR>0.6) = 1;   % 1��������

% ����RR��ֵ
X11RR=x_train(1:5000,253:253);   % ���Ų���5000
X11RR=X11RR';
X22RR=x_train(5001:10000,253:253);  % ���粨��5000
X22RR=X22RR';

X112RR=X11RR(:,4001:5000);  % Nȡ1000������

X222RR=X22RR(:,4001:5000);  % Vȡ1000������

XXRR=[X112RR X222RR] ;  % ���Լ�:һ��Ϊһ������
XXRR_pre = XXRR';
XXRR(XXRR<=1) = 0;  % 0��������
XXRR(XXRR>1) = 1;   % 1��������

% �ж�����
for i=1:2000
    if res(i)==0 && XXR(i)==0 && XXRR(i)==0
        res(i) = 1;
    elseif res(i)==1 && XXR(i)==1 && XXRR(i)==1
        res(i) = 0;
    end
end
%
%
%
%


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
