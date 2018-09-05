% 模型三
% RR间期特征加入
clear all
clc
% 加载数据
load('S:\二次实验\所有NV\train_Data.csv');

x_train = train_Data;
X11=x_train(1:5000,1:250);   % 干扰波形5000
X11=X11';
X22=x_train(5001:10000,1:250);  % 室早波形5000
X22=X22';


X111=X11(:,1:4000);     % N取4000做训练
X112=X11(:,4001:5000);  % N取1000做测试


X221=X22(:,1:4000);     % V取4000做训练
X222=X22(:,4001:5000);  % V取1000做测试


X=[X111 X221];    % 训练集:一列为一个样本
XX=[X112 X222] ;  % 测试集:一列为一个样本

% 建立训练集标签 00 01
y1=zeros(2,8000);
for i=4001:8000
    y1(2,i)=1;
end


% 设置随机种子
setdemorandstream(pi)

FlattenedData = X(:)'; % 展开矩阵为一列，然后转置为一行。
MappedFlattened = mapminmax(FlattenedData, 0, 1); % 归一化。
X = reshape(MappedFlattened, size(X)); % 还原为原始矩阵形式。此处不需转置回去，因为reshape恰好是按列重新排序

%%%%%%%%%%%%%%%%%%%%%
%%%% 建立神经网络 %%%%
%%%%%%%%%%%%%%%%%%%%%
net=newff(minmax(X),[23,2],{'tansig','purelin'},'trainlm');
net.trainParam.show=10; %设置数据显示刷新频率，学习次刷新一次图象
net.trainParam.epochs=1000; %最大 训练次数
net.trainParam.goal=4.5e-4; % 设置训练误差
net=init(net);%网络初始化
[net, tr]=train(net,X,y1);%训练网络
disp('BP神经网络训练完成！');

FlattenedData1 = XX(:)'; % 展开矩阵为一列，然后转置为一行。
MappedFlattened1 = mapminmax(FlattenedData1, 0, 1); % 归一化。
XX = reshape(MappedFlattened1, size(XX)); % 还原为原始矩阵形式。此处不需转置回去，因为reshape恰好是按列重新排序

result_test1 = sim(net,XX);%测试样本仿真
result_test = result_test1;

result_test( result_test>0.55)=1;
result_test( result_test<=0.55)=0;

disp('网络输出:')
result_test;
jieguo = result_test';

t1=zeros(1,1000);
t2=ones(1,1000);

pp_lab=[t1 t2]; % 测试样本标签（正确类别）
res = vec2ind(result_test)-1; % 向量值变索引值
res_pre = res';
%
%
%加入R-pre
X11R=x_train(1:5000,251:251);   % 干扰波形5000
X11R=X11R';
X22R=x_train(5001:10000,251:251);  % 室早波形5000
X22R=X22R';

X112R=X11R(:,4001:5000);  % N取1000做测试

X222R=X22R(:,4001:5000);  % V取1000做测试

XXR=[X112R X222R] ;  % 测试集:一列为一个样本
XXR1 = XXR';
XXR(XXR<=0.6) = 0;  % 0代表室早
XXR(XXR>0.6) = 1;   % 1代表正常

% 加入RR比值
X11RR=x_train(1:5000,253:253);   % 干扰波形5000
X11RR=X11RR';
X22RR=x_train(5001:10000,253:253);  % 室早波形5000
X22RR=X22RR';

X112RR=X11RR(:,4001:5000);  % N取1000做测试

X222RR=X22RR(:,4001:5000);  % V取1000做测试

XXRR=[X112RR X222RR] ;  % 测试集:一列为一个样本
XXRR_pre = XXRR';
XXRR(XXRR<=1) = 0;  % 0代表室早
XXRR(XXRR>1) = 1;   % 1代表正常

% 判定条件
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
        strr{i} = '0'; % 测试 = 标签
        kk=kk+1;
    else
        strr{i} = '1'; % 测试 != 标签
    end
end
result = strr';
acc=kk/size(pp_lab,2);
plotconfusion(pp_lab, res);
disp('预测完成！');
