function [ gimme_a_name ] = disSimMat_classification(d , size_train_vec , classifier)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if strcmp(classifier , 'parzen')
    clfr = parzenddc;
elseif strcmp(classifier , 'knn')
    clfr = knndc([] , 1);
end

for i = 1 : length(size_train_vec)
    [dt , ds] = getDissimData(d , size_train_vec(i) , size_train_vec(i) , 'random');
    
    w = dt * clfr;
    classification = ds * w;
    lab = classification * labeld;

    e(i) = classification * testc;
    cmat{i} = confmat(getlab(ds), lab);
end

gimme_a_name = struct();

gimme_a_name.classifier = classifier;
gimme_a_name.trainSetSizes = size_train_vec;
gimme_a_name.errors = e;
gimme_a_name.errorsMean = mean(e);
gimme_a_name.errorsVar = var(e);
gimme_a_name.confMatrices = cmat;


end

