function [gimme_a_name] = raw_classification(dataset)

classifier = knnc([],1);
training_samples = 100; %number of samples per class

for i=1:10
    %generate training/test set by having balanced classes
    [train, test] = gendat(dataset, training_samples*ones(1,10)); 

    w = train*classifier*classc; %train the classifier

    classification = test*w; %test the classifier on the test set

    lab = classification*labeld; %get the 'predicted' labeling 

    [e(i),c] = testc(classification); %performance of the classifier
end

cmat = confmat( getlab(test), lab ); %compute confusion matrix

%save a struct in the workspace, ready to be saved in a file

gimme_a_name = struct();

gimme_a_name.w = w;
gimme_a_name.e = e;
gimme_a_name.c = c;
gimme_a_name.cmat = cmat;
gimme_a_name.mean = mean(e);
gimme_a_name.var = var(e);

%SAVE gimme_a_name!!!
