function [stat] = PRpipeline(dataset_, pca_, kernel_, classifier_)
%% Classify dataset making use of the specified pipeline.
%
% USAGE
% stat = PRpipeline(dataset, PCA, Kernel, Classifier)
%
% examples
% stat = PRpipeline(raw, 0.9, 30000, fisherc)
% stat = PRpipeline(smoothed, 0, 0, knnc)
% 
% pca is specified by means of the fraction of cumulative variance
%   if zero, no PCA is employed.
% kernel is always gaussian and it is only possible to choose its variance.
%   if zero, no kernel is employed.

prwarning(0);
prwaitbar off;

lambda = 0; %Kernel Regularization

if kernel_ ~= 0
    kernel_type = proxm([], 'r', kernel_);
end

if pca_ ~= 0
    pca = scalem([],'variance')*pcam([],pca_);
end

training_samples = 150; %number of samples per class

disp('');

for i=1:5
    disp( ['REP #' num2str(i) ] );
    
    %generate a balanced training/test set
    [train, test] = gendat(dataset_, 0.75);
    
    if pca_ ~= 0
        disp('PCA time'); tic;
        dict = train*pca;

        train = train*dict;
        test = test*dict;
        
        disp(dict);
        toc; fprintf('\n');
    end
    
    if kernel_ ~= 0
        disp('Kernelization time'); tic;
        kernel = train*kernel_type;

        train = train*kernel + lambda*eye(size(train,1));
        test = test*kernel;
        toc; fprintf('\n');
    end
    
    disp('Training time'); tic
    w = train*classifier_*classc; %train the classifier
    toc; fprintf('\n');
    
    disp('Classificaton time');
    tic
    classification = test*w; %test the classifier on the test set
    toc; fprintf('\n');
    
    lab = classification*labeld; %get the 'predicted' labeling 
    
    [e(i),c(i,:)] = testc(classification); %performance of the classifier
    
    % display output
    disp(['Test error: ' num2str( e(i)*100 ) '%' ]);
    disp('Misclassifications per class');
    disp(c(i,:));
    cmat(i,:,:) = confmat( getlab(test), lab );
end
    

%save a struct in the workspace, ready to be saved in a file

stat = struct();

stat.e = e;
stat.c = c;
stat.cmat = cmat;
stat.mean = mean(e)*100;
stat.var = var(e);

%SAVE gimme_a_name!!!