% function test_example_CNN
clear all;
clc;

load ('P:\Matlabx\ThreeTime_CNN.mat');

train_x = double(reshape(train_x',32,32,5000))/255;
test_x = double(reshape(test_x',32,32,2500))/255;
% train_x = double(reshape(train_x',64,64,8000))/255;
% test_x = double(reshape(test_x',64,64,2000))/255;
train_y = double(train_y');
test_y = double(test_y');

%% ex1 Train a 6c-2s-12c-2s Convolutional neural network 
rand('state',0)

cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %sub sampling layer
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
};


opts.alpha = 1;
opts.batchsize = 25;
opts.numepochs = 1;

cnn = cnnsetup(cnn, train_x, train_y);
cnn = cnntrain(cnn, train_x, train_y, opts);

[er, bad] = cnntest(cnn, test_x, test_y);

 net = cnnff(cnn, test_x);
    [~, h] = max(net.o);
    [~, a] = max(test_y);
    bad = find(h ~= a);
    er = numel(bad) / size(test_y, 2);
% print(er);
% print(bad);
%plot mean squared error
jieguo2 = h;
figure; 
plot(cnn.rL);
disp(1-er);
disp(bad);
% assert(er<0.12, 'Too big error');
