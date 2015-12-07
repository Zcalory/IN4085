raw = loadDataset(); %load dataset

classifier = knn([],1);
training_samples = 100; %number of samples per class

%generate training/test set by having balanced classes
[train, test] = gendat(raw, training_samples*ones(1,10)); clear raw; 

w = train*classifier*classc; %train the classifier

classification = test*w; %test the classifier on the test set

lab = classification*labeld; %get the 'predicted' labeling 

[e,c] = testc(classification); %performance of the classifier

cmat = confmat( getlab(test), lab ); %compute confusion matrix

%save a struct in the workspace, ready to be saved in a file

gimme_a_name = struct();

gimme_a_name.w = w;
gimme_a_name.e = e;
gimme_a_name.c = c;
gimme_a_name.cmat = cmat;

%SAVE gimme_a_name!!!
