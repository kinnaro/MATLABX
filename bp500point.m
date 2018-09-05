load('orimat.mat')
%计算了error
X1=X1(1:64000);
X11=reshape(X1,512,125);
X111=X11(:,1:65);
X112=X11(:,66:125);
X2=X2(1:64000);
X22=reshape(X2,512,125);
X221=X22(:,1:65);
X222=X22(:,66:125);
X3=X3(1:64000);
X33=reshape(X3,512,125);
X331=X33(:,1:65);
X332=X33(:,66:125);
X4=X4(1:64000);
X44=reshape(X4,512,125);
X441=X44(:,1:65);
X442=X44(:,66:125);
X=[X111 X221 X331 X441];
XX=[X112 X222 X332 X442];


y1=zeros(4,260);
for i=1:65
    y1(1,i)=1;
end
for i=66:130
    y1(2,i)=1;
end
for i=131:195
    y1(3,i)=1;
end
for i=196:260
y1(4,i)=1;
end

[X, s1] = mapminmax(X);
net=newff(minmax(X),[50,4],{'tansig','purelin'},'trainlm');
net.trainParam.show=10; %设置数据显示刷新频率，学习次刷新一次图象
net.trainParam.epochs=1000; %最大 训练次数
net.trainParam.goal=1e-5; % 设置训练误差
net=init(net);%网络初始化
[net tr]=train(net,X,y1);%训练网络


XX = mapminmax('apply',XX,s1);%测试样本归一化
 result_test=sim(net,XX)%测试样本仿真
 
   result_test( result_test>0.85)=1;
  result_test( result_test<=0.85)=0; 
  disp('网络输出:')
  result_test
  
  
   t1=ones(1,60);
    t2=2*ones(1,60);
     t3=3*ones(1,60);
      t4=4*ones(1,60);
      
   
  pp_lab=[t1 t2 t3 t4];% 测试样本标签（正确类别）
 res=vec2ind(result_test)%向量值变索引值
 strr = cell(1,240);
 kk=0;
for i=1:240
   if res(i) == pp_lab(i)
       strr{i} = '正确';
       kk=kk+1;
   else
       strr{i} = '错误';
   end
end
er=kk/size(pp_lab,2);
er=1-er;


diag = {'正常','故障1', '故障2', '故障3', };
disp('诊断结果：')
fprintf('  样本序号    实际类别    判断类别      正/误       故障类型 \n');
for i =1:240
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
