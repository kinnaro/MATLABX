% ģ��һ
% ������RR��������
clear all
clc
% ��������
% load('S:\����ʵ��\����NV\train_Data.csv');
load('S:\����ʵ��\train_Data_200.csv');

% x_train = train_Data;
x_train = train_Data_200;
X11=x_train(1:5000,2:204);   % ���Ų���5000
X11=X11';
X22=x_train(5001:10000,2:204);  % ���粨��5000
X22=X22';


X111=X11(:,1:4000);     % Nȡ4000��ѵ��
X112=X11(:,4001:5000);  % Nȡ1000������


X221=X22(:,1:4000);     % Vȡ4000��ѵ��
X222=X22(:,4001:5000);  % Vȡ1000������


X=[X111 X221];    % ѵ����:һ��Ϊһ������
XAA = X;
XX=[X112 X222] ;  % ���Լ�:һ��Ϊһ������

% ����ѵ������ǩ 00 01
y1=zeros(2,8000);
for i=4001:8000
    y1(2,i)=1;
end



FlattenedData = X(:)'; % չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
MappedFlattened = mapminmax(FlattenedData, 0, 1); % ��һ����
X = reshape(MappedFlattened, size(X)); % ��ԭΪԭʼ������ʽ���˴�����ת�û�ȥ����Ϊreshapeǡ���ǰ�����������
% ������������
hidden = [20,21,22,23,24,25,26,27,28,29];
% hidden = [26,27,28,29];
error_train = [1e-4,2e-4,3e-4,4e-4,5e-4,6e-4,7e-4,8e-4,9e-4,1e-3];
yuzhi = [0.4,0.5,0.6,0.7];
jishu = 1;

for ii=9:9
    for jj=4:10
        for kkk=1:4
             % �����������
            setdemorandstream(pi)
            %%%%%%%%%%%%%%%%%%%%%
            %%%% ���������� %%%%
            %%%%%%%%%%%%%%%%%%%%%
            net=newff(minmax(X),[hidden(ii),2],{'tansig','purelin'},'trainlm');
            net.trainParam.show=10; %����������ʾˢ��Ƶ�ʣ�ѧϰ��ˢ��һ��ͼ��
            net.trainParam.epochs=100; %��� ѵ������
            
            net.trainParam.goal=error_train(jj); % ����ѵ�����
            net=init(net);%�����ʼ��
            [net, tr]=train(net,X,y1);%ѵ������
%             disp('BP������ѵ����ɣ�');
            
            FlattenedData1 = XX(:)'; % չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
            MappedFlattened1 = mapminmax(FlattenedData1, 0, 1); % ��һ����
            XX = reshape(MappedFlattened1, size(XX)); % ��ԭΪԭʼ������ʽ���˴�����ת�û�ȥ����Ϊreshapeǡ���ǰ�����������
            
            result_test1 = sim(net,XX);%������������
            result_test = result_test1;
            
            result_test( result_test>yuzhi(kkk))=1;
            result_test( result_test<=yuzhi(kkk))=0;
%             disp('�������:')
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
            acc(jishu)=kk/size(pp_lab,2);
            hidden_res(jishu) = hidden(ii)
            error_train_res(jishu) = error_train(jj)
            yuzhi_res(jishu) = yuzhi(kkk)
            ii_res(jishu) = ii;
            jj_res(jishu) = jj;
            kkk_res(jishu) = kkk;
            acc = acc';
            hidden_res = hidden_res';
            error_train_res = error_train_res';
            yuzhi_res = yuzhi_res';
            jishu = jishu + 1;
        end
    end
end
% plotconfusion(pp_lab, res);
% disp('Ԥ����ɣ�');
