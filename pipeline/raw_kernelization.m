function [gimme_a_name] = raw_kernelization(dataset)

classifier = fisherc;
kernel_type = proxm([], 'r', 5000);
lambda = 0;

training_samples = 150; %number of samples per class

%generate training/test set by having balanced classes

for i=1:10
    [train, test] = gendat(dataset, training_samples*ones(1,10));

    kernel = train*kernel_type;

    train_k = train*kernel + lambda*eye(size(train,1));
    test_k = test*kernel;

    w = train_k*classifier*classc; %train the classifier

    classification = test_k*w; %test the classifier on the test set

    lab = classification*labeld; %get the 'predicted' labeling 

    [e(i),c] = testc(classification); %performance of the classifier

end
    
cmat = confmat( getlab(test_k), lab ); %compute confusion matrix

%save a struct in the workspace, ready to be saved in a file

gimme_a_name = struct();

gimme_a_name.w = w;
gimme_a_name.e = e;
gimme_a_name.c = c;
gimme_a_name.cmat = cmat;
gimme_a_name.mean = mean(e);
gimme_a_name.var = var(e);

%SAVE gimme_a_name!!!