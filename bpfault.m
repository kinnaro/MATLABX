clc
clear
load ('ѵ����8000+���Լ�2000-2-32.mat');
train_x = double(reshape(train_x',1024,8000))/255;
test_x = double(reshape(test_x',1024,2000))/255;
train_y = double(train_y');
test_y = double(test_y');
% [p, s1] = mapminmax(train_x);
p = train_x;
%����������һ�� ��һ���ķ�Χ�ǣ�-1,1����s1 ��¼��һ���Ĳ���
net=newff(minmax(p),[50,2],{'tansig','purelin'},'trainlm');
%�½�BP���磬pΪ�������룺p=martric(5*30) �ֱ��ʾ5����������30������
% ������Ԫ����Ϊ60���������Ŀ��tȷ���������Ԫ����Ϊ5��
% ������㵽����ļ�������Ϊ˫�����У����㵽�����ļ�������Ϊ���Ժ�����ѵ����������LM��Levenberg-Marquardt���㷨�����������sita={W,b}�ĸ���
%%��������ѵ������
net.trainParam.show=10; %����������ʾˢ��Ƶ�ʣ�ѧϰ��ˢ��һ��ͼ��
net.trainParam.epochs=1000; %��� ѵ������
net.trainParam.goal=1e-5; % ����ѵ�����
net=init(net);%�����ʼ��
[net,tr]=train(net,p,train_y);%ѵ������

%%testing
pp = test_x;
result_test=sim(net,pp);%������������

result_test( result_test>0.85)=1;
result_test( result_test<=0.85)=0;
disp('�������:')
result_test;

%  pp_lab=[2 1 5 4 3 5];% ����������ǩ����ȷ���
pp_lab=test_y;
res=vec2ind(result_test);%����ֵ������ֵ
strr = cell(1,2);
for i=1:2
    if res(i) == pp_lab(i)
        strr{i} = '��ȷ';
    else
        strr{i} = '����';
    end
end

diag = {'����','����1', '����2', '����3', '����4'  };
disp('��Ͻ����')
fprintf('  �������    ʵ�����    �ж����      ��/��       �������� \n');
for i =1:2
    fprintf('     %d           %d         %d          %s      %s\n',...
        i, pp_lab(i), res(i), strr{i},  diag{res(i)});
end
figure
plot(pp_lab,'-g*');
hold on
plot(res,'-ro')
legend('��������','Ԥ����������')
xlabel('����')
ylabel('����')
title('��������')