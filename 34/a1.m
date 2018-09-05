% Load data
%受内存限制，一般不能运行
% load ’mnist_uint8.mat’
ind = randperm(size(train_X, 1));
train_X = train_X(ind(1:5000),:);
train_labels = train_labels(ind(1:5000));
% Set parameters
no_dims = 2;
initial_dims = 50;
perplexity = 30;
% Run t?SNE
mappedX = tsne(train_X, [], no_dims, initial_dims, perplexity);
% Plot results
gscatter(mappedX(:,1), mappedX(:,2), train_labels);
