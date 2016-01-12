function [ gimme_a_name ] = disSimSpace_classification( d , size_train_vec , size_rep_vec , feat_sel_method , classifier )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
switch lower(classifier)  %TODO: Define more classifiers later
    case 'ldc'
        clfr = ldc;
    case 'nmc'
        clfr = nmc;
    case 'knn'
        clfr = knnc([] , 1);
    case 'parzen'
        clfr = parzenc;
    case 'svm'
        clfr = svc;
end

for i = 1 : length(size_train_vec)
    for j = 1 : length(size_rep_vec)
        [dt , ds] = getDissimData(d , size_train_vec(i) , size_rep_vec(j) , feat_sel_method);

        w = dt * clfr;
        classification = ds * w;
        lab = classification * labeld;

        e(i , j) = classification * testc;
        cmat{i , j} = confmat(getlab(ds), lab);
    end
end

gimme_a_name.classifier = classifier;
gimme_a_name.trainSetSizes = size_train_vec;
gimme_a_name.RepSetSizes = size_rep_vec;
gimme_a_name.FeatSelMethod = feat_sel_method;
gimme_a_name.errors = e;
gimme_a_name.errorsMean = mean(mean(e));
gimme_a_name.errorsVar = var(var(e));
gimme_a_name.confMatrices = cmat;




end

