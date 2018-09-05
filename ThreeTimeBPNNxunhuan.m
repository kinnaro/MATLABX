% ģ��һ
% ������RR��������
clear
clc
% ��������
% load('S:\����ʵ��\����NV\train_Data.csv');
load('S:\ThreeTime\train_Data_NVLRA_CNN.csv');

% x_train = train_Data;
x_train = train_Data_NVLRA_CNN;
X11=x_train(1:4000,2:204);   % N����5000
X11=X11';
X22=x_train(4001:8000,2:204);  % V����5000
X22=X22';
X33=x_train(8001:12000,2:204);   % L����5000
X33=X33';
X44=x_train(12001:16000,2:204);  % R����5000
X44=X44';
X55=x_train(16001:18500,2:204);   % A����2500
X55=X55';



X111=X11(:,1:3600);     % Nȡ3600��ѵ��
X112=X11(:,3601:4000);  % Nȡ400������


X221=X22(:,1:3600);     % Vȡ3600��ѵ��
X222=X22(:,3601:4000);  % Vȡ400������

X331=X33(:,1:3600);     % Lȡ3600��ѵ��
X332=X33(:,3601:4000);  % Lȡ400������

X441=X44(:,1:3600);     % Rȡ3600��ѵ��
X442=X44(:,3601:4000);  % Rȡ400������

X551=X55(:,1:2250);     % Aȡ2250��ѵ��
X552=X55(:,2251:2500);  % Aȡ250������


X=[X111 X221 X331 X441 X551];    % ѵ����:һ��Ϊһ������
XAA = X;
XX=[X112 X222 X332 X442 X552] ;  % ���Լ�:һ��Ϊһ������

% ����ѵ������ǩ 00 01
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




FlattenedData = X(:)'; % չ������Ϊһ�У�Ȼ��ת��Ϊһ�С�
MappedFlattened = mapminmax(FlattenedData, 0, 1); % ��һ����
X = reshape(MappedFlattened, size(X)); % ��ԭΪԭʼ������ʽ���˴�����ת�û�ȥ����Ϊreshapeǡ���ǰ�����������
% ������������
hidden = [28,32];
% hidden = [23,22];
% hidden = [26,27,28,29];
error_train = [0.008,8e-4];
yuzhi = [0.6,0.5];
jishu = 1;

for ii=2:2
    for jj=1:1
        for kkk=1:1
             % �����������
            setdemorandstream(pi)
            %%%%%%%%%%%%%%%%%%%%%
            %%%% ���������� %%%%
            %%%%%%%%%%%%%%%%%%%%%
            net=newff(minmax(X),[hidden(ii),5],{'tansig','purelin'},'trainlm');
            net.trainParam.show=10; %����������ʾˢ��Ƶ�ʣ�ѧϰ��ˢ��һ��ͼ��
            net.trainParam.epochs=1000; %��� ѵ������
%             net.trainParam.lr=0.6;
            
            net.trainParam.goal=error_train(jj); % ����ѵ�����
            net=init(net);%�����ʼ��
            [net, tr]=train(net,X,y1);%ѵ������
%             disp('BP������ѵ����ɣ�');
            
            tic;    %��ʱ��ʼ
            
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
            
            pp_lab=y_ce; % ����������ǩ����ȷ���
            pp_lab = vec2ind(pp_lab);
            res = vec2ind(result_test); % ����ֵ������ֵ
            strr = cell(1,1850);
            kk=0;
            for i=1:1850
                if res(i) == pp_lab(i)
                    strr{i} = '0'; % ���� = ��ǩ
                    kk=kk+1;
                else
                    strr{i} = '1'; % ���� != ��ǩ
                end
            end
            result = strr';            
            acc(jishu)=kk/size(pp_lab,2);
            
            toc;    %��ʱ����
            
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
% disp('Ԥ����ɣ�');
