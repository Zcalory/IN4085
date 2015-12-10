raw = loadDataset(); %load dataset

classifier = fisherc;
kernel = proxm([], 'r', 23);

training_samples = 100; %number of samples per class

%generate training/test set by having balanced classes
[train, test] = gendat(raw, training_samples*ones(1,10)); clear raw; 

kernel = train*kernel;

train_k = train*kernel;
test_k = test*kernel;

w = train_k*classifier*classc; %train the classifier

classification = test_k*w; %test the classifier on the test set

lab = classification*labeld; %get the 'predicted' labeling 

[e,c] = testc(classification); %performance of the classifier

cmat = confmat( getlab(test_k), lab ); %compute confusion matrix

%save a struct in the workspace, ready to be saved in a file

gimme_a_name = struct();

gimme_a_name.w = w;
gimme_a_name.e = e;
gimme_a_name.c = c;
gimme_a_name.cmat = cmat;

%SAVE gimme_a_name!!!