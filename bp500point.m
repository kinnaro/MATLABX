load('orimat.mat')
%������error
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
net.trainParam.show=10; %����������ʾˢ��Ƶ�ʣ�ѧϰ��ˢ��һ��ͼ��
net.trainParam.epochs=1000; %��� ѵ������
net.trainParam.goal=1e-5; % ����ѵ�����
net=init(net);%�����ʼ��
[net tr]=train(net,X,y1);%ѵ������


XX = mapminmax('apply',XX,s1);%����������һ��
 result_test=sim(net,XX)%������������
 
   result_test( result_test>0.85)=1;
  result_test( result_test<=0.85)=0; 
  disp('�������:')
  result_test
  
  
   t1=ones(1,60);
    t2=2*ones(1,60);
     t3=3*ones(1,60);
      t4=4*ones(1,60);
      
   
  pp_lab=[t1 t2 t3 t4];% ����������ǩ����ȷ���
 res=vec2ind(result_test)%����ֵ������ֵ
 strr = cell(1,240);
 kk=0;
for i=1:240
   if res(i) == pp_lab(i)
       strr{i} = '��ȷ';
       kk=kk+1;
   else
       strr{i} = '����';
   end
end
er=kk/size(pp_lab,2);
er=1-er;


diag = {'����','����1', '����2', '����3', };
disp('��Ͻ����')
fprintf('  �������    ʵ�����    �ж����      ��/��       �������� \n');
for i =1:240
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
