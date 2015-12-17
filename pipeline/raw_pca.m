function [gimme_a_name] = raw_pca(dataset)

classifier = fisherc;
kernel_type = proxm([], 'r', 75);
pca = scalem([],'variance')*pcam([],0.99);
lambda = 0;

training_samples = 100; %number of samples per class

%generate training/test set by having balanced classes

for i=1:1
    disp( ['******* ' num2str(i) ' *******'] );
    
    [tr, te] = gendat(dataset, training_samples*ones(1,10));
    
    dict = tr*pca;
    
    train = tr*dict;
    test = te*dict;
    
    disp(dict);
    
    kernel = train*kernel_type;

    train_k = train*kernel + lambda*eye(size(train,1));
    test_k = test*kernel;

    w = train_k*classifier*classc; %train the classifier

    classification = test_k*w; %test the classifier on the test set

    lab = classification*labeld; %get the 'predicted' labeling 

    [e(i),c(i,:)] = testc(classification); %performance of the classifier
    
    disp(e);
    disp(c(i,:));
    
    disp('***************************************');
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