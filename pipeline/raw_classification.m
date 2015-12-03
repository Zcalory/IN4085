raw = loadDataset();

classifier = bpxnc([],[10 10 10 10 10 10 10 10 10 10 10 10 10 10 10],5000);
training_samples = 100; %samples per class

[train, test] = gendat(raw, training_samples*ones(1,10)); clear raw;

w = train*classifier*classc;

classification = test*w;

lab = classification*labeld;

[e,c] = testc(classification);

cmat = confmat( getlab(test), lab );

gimme_a_name = struct();

gimme_a_name.w = w;
gimme_a_name.e = e;
gimme_a_name.c = c;
gimme_a_name.cmat = cmat;

%SAVE gimme_a_name!!!