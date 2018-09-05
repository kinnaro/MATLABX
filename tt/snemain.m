load('BPtrain_x.mat')
load('BPtrain_y.mat')
% Load data
train_X=train_x;
train_labels=train_y;
% load ’mnist_train.mat’
% Set parameters
no_dims = 2;
initial_dims = 50;%一般写成50，若该值本来就小于50则应适当修改
perplexity = 30;
% Run t?SNE
mappedX = tsne(train_X, [], no_dims, initial_dims, perplexity);
% Plot results
gscatter(mappedX(:,1), mappedX(:,2), train_labels);
% gscatter(mappedX(:,1), mappedX(:,2),mappedX(:,3), train_labels);
