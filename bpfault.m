clc
clear
load ('训练集8000+测试集2000-2-32.mat');
train_x = double(reshape(train_x',1024,8000))/255;
test_x = double(reshape(test_x',1024,2000))/255;
train_y = double(train_y');
test_y = double(test_y');
% [p, s1] = mapminmax(train_x);
p = train_x;
%输入样本归一化 归一化的范围是（-1,1），s1 记录归一化的参数
net=newff(minmax(p),[50,2],{'tansig','purelin'},'trainlm');
%新建BP网络，p为样本输入：p=martric(5*30) 分别表示5个传感器，30个样本
% 隐层神经元个数为60，根据输出目标t确定输出层神经元个数为5，
% 从输入层到隐层的激励函数为双曲正切，隐层到输出层的激励函数为线性函数，训练方法利用LM（Levenberg-Marquardt）算法进行网络参数sita={W,b}的更新
%%设置网络训练参数
net.trainParam.show=10; %设置数据显示刷新频率，学习次刷新一次图象
net.trainParam.epochs=1000; %最大 训练次数
net.trainParam.goal=1e-5; % 设置训练误差
net=init(net);%网络初始化
[net,tr]=train(net,p,train_y);%训练网络

%%testing
pp = test_x;
result_test=sim(net,pp);%测试样本仿真

result_test( result_test>0.85)=1;
result_test( result_test<=0.85)=0;
disp('网络输出:')
result_test;

%  pp_lab=[2 1 5 4 3 5];% 测试样本标签（正确类别）
pp_lab=test_y;
res=vec2ind(result_test);%向量值变索引值
strr = cell(1,2);
for i=1:2
    if res(i) == pp_lab(i)
        strr{i} = '正确';
    else
        strr{i} = '错误';
    end
end

diag = {'正常','故障1', '故障2', '故障3', '故障4'  };
disp('诊断结果：')
fprintf('  样本序号    实际类别    判断类别      正/误       故障类型 \n');
for i =1:2
    fprintf('     %d           %d         %d          %s      %s\n',...
        i, pp_lab(i), res(i), strr{i},  diag{res(i)});
end
figure
plot(pp_lab,'-g*');
hold on
plot(res,'-ro')
legend('期望类型','预测数出类型')
xlabel('样本')
ylabel('类型')
title('故障类型')