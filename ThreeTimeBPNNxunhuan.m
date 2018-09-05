% 模型一
% 不加入RR间期特征
clear
clc
% 加载数据
% load('S:\二次实验\所有NV\train_Data.csv');
load('S:\ThreeTime\train_Data_NVLRA_CNN.csv');

% x_train = train_Data;
x_train = train_Data_NVLRA_CNN;
X11=x_train(1:4000,2:204);   % N波形5000
X11=X11';
X22=x_train(4001:8000,2:204);  % V波形5000
X22=X22';
X33=x_train(8001:12000,2:204);   % L波形5000
X33=X33';
X44=x_train(12001:16000,2:204);  % R波形5000
X44=X44';
X55=x_train(16001:18500,2:204);   % A波形2500
X55=X55';



X111=X11(:,1:3600);     % N取3600做训练
X112=X11(:,3601:4000);  % N取400做测试


X221=X22(:,1:3600);     % V取3600做训练
X222=X22(:,3601:4000);  % V取400做测试

X331=X33(:,1:3600);     % L取3600做训练
X332=X33(:,3601:4000);  % L取400做测试

X441=X44(:,1:3600);     % R取3600做训练
X442=X44(:,3601:4000);  % R取400做测试

X551=X55(:,1:2250);     % A取2250做训练
X552=X55(:,2251:2500);  % A取250做测试


X=[X111 X221 X331 X441 X551];    % 训练集:一列为一个样本
XAA = X;
XX=[X112 X222 X332 X442 X552] ;  % 测试集:一列为一个样本

% 建立训练集标签 00 01
y1=zeros(5,16650);
for i=3601:7200
    y1(2,i)=1;
end
for i=7201:10800
    y1(3,i)=1;
end
for i=10801:14400
    y1(4,i)=1;
end
for i=14401:16650
    y1(5,i)=1;
end




FlattenedData = X(:)'; % 展开矩阵为一列，然后转置为一行。
MappedFlattened = mapminmax(FlattenedData, 0, 1); % 归一化。
X = reshape(MappedFlattened, size(X)); % 还原为原始矩阵形式。此处不需转置回去，因为reshape恰好是按列重新排序
% 定义三个参数
hidden = [28,32];
% hidden = [23,22];
% hidden = [26,27,28,29];
error_train = [0.008,8e-4];
yuzhi = [0.6,0.5];
jishu = 1;

for ii=2:2
    for jj=1:1
        for kkk=1:1
             % 设置随机种子
            setdemorandstream(pi)
            %%%%%%%%%%%%%%%%%%%%%
            %%%% 建立神经网络 %%%%
            %%%%%%%%%%%%%%%%%%%%%
            net=newff(minmax(X),[hidden(ii),5],{'tansig','purelin'},'trainlm');
            net.trainParam.show=10; %设置数据显示刷新频率，学习次刷新一次图象
            net.trainParam.epochs=1000; %最大 训练次数
%             net.trainParam.lr=0.6;
            
            net.trainParam.goal=error_train(jj); % 设置训练误差
            net=init(net);%网络初始化
            [net, tr]=train(net,X,y1);%训练网络
%             disp('BP神经网络训练完成！');
            
            tic;    %计时开始
            
            FlattenedData1 = XX(:)'; % 展开矩阵为一列，然后转置为一行。
            MappedFlattened1 = mapminmax(FlattenedData1, 0, 1); % 归一化。
            XX = reshape(MappedFlattened1, size(XX)); % 还原为原始矩阵形式。此处不需转置回去，因为reshape恰好是按列重新排序
            
            result_test1 = sim(net,XX);%测试样本仿真
            result_test = result_test1;
            
            result_test( result_test>yuzhi(kkk))=1;
            result_test( result_test<=yuzhi(kkk))=0;
%             disp('网络输出:')
            result_test;
            jieguo = result_test';
            
            y_ce=zeros(5,1850);
            for i=401:800
                y_ce(2,i)=1;
            end
            for i=801:1200
                y_ce(3,i)=1;
            end
            for i=1201:1600
                y_ce(4,i)=1;
            end
            for i=1601:1850
                y_ce(5,i)=1;
            end
            
            pp_lab=y_ce; % 测试样本标签（正确类别）
            pp_lab = vec2ind(pp_lab);
            res = vec2ind(result_test); % 向量值变索引值
            strr = cell(1,1850);
            kk=0;
            for i=1:1850
                if res(i) == pp_lab(i)
                    strr{i} = '0'; % 测试 = 标签
                    kk=kk+1;
                else
                    strr{i} = '1'; % 测试 != 标签
                end
            end
            result = strr';            
            acc(jishu)=kk/size(pp_lab,2);
            
            toc;    %计时结束
            
            hidden_res(jishu) = hidden(ii)
            error_train_res(jishu) = error_train(jj)
            yuzhi_res(jishu) = yuzhi(kkk)
            acc = acc';
            hidden_res = hidden_res';
            error_train_res = error_train_res';
            yuzhi_res = yuzhi_res';
            ii_res(jishu) = ii;
            jj_res(jishu) = jj;
            kkk_res(jishu) = kkk;
            jishu = jishu + 1;
        end
    end
end
% plotconfusion(pp_lab, res);
% disp('预测完成！');
