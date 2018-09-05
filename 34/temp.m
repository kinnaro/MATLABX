temp1=zeros(2800,256);
temp1(1:700,:)=train_X(1:700,:);
temp1(701:1400,:)=train_X(4001:4700,:);
temp1(1401:2100,:)=train_X(7001:7700,:);
temp1(2101:2800,:)=train_X(10001:10700,:);
train_X=temp1;

temp2=zeros(2800,4);
temp2(1:700,:)=train_labels(1:700,:);
temp2(701:1400,:)=train_labels(4001:4700,:);
temp2(1401:2100,:)=train_labels(7001:7700,:);
temp2(2101:2800,:)=train_labels(10001:10700,:);

train_labels=temp2;



train_X=s0;
train_labels=ss0;
test_X=p;
