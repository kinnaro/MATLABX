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
% X=X';
XX=[X112 X222] ;  % ���Լ�:һ��Ϊһ������
% XX=XX';

% ����ѵ������ǩ 00 01
y1=zeros(2,8000);
for i=4001:8000
    y1(2,i)=1;
end
% y1=zeros(8000,2);
% for i=4000:8000
%     y1(i,2)=1;
% end



% �����������
setdemorandstream(pi)

FlattenedData = X(:)'; % չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
MappedFlattened = mapminmax(FlattenedData, 0, 1); % ��һ����
X = reshape(MappedFlattened, size(X)); % ��ԭΪԭʼ������ʽ���˴�����ת�û�ȥ����Ϊreshapeǡ���ǰ�����������

% [X, s1] = mapminmax(X);
net=newff(minmax(X),[23,2],{'tansig','purelin'},'trainlm');
net.trainParam.show=10; %����������ʾˢ��Ƶ�ʣ�ѧϰ��ˢ��һ��ͼ��
net.trainParam.epochs=1000; %��� ѵ������
net.trainParam.goal=4.5e-4; % ����ѵ�����
net=init(net);%�����ʼ��
[net, tr]=train(net,X,y1);%ѵ������
disp('BP������ѵ����ɣ�');

% XX = mapminmax('apply',XX,s1);%����������һ��
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
