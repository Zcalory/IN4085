function [ gimme_a_name ] = disSimPE_classification(d , size_train_vec , classifier)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

switch lower(classifier)
    case 'nmcpe'
        clfr = pe_nmc;
    case 'knnpe'
        clfr = pe_knnc;
    case 'parzenpe'
        clfr = pe_parzenc;
    case 'svmpe'
        clfr = pe_libsvc;
end


for i = 1 : length(size_train_vec)
    [dt , ds] = getDissimData(d , size_train_vec(i) , size_train_vec(i) , 'random');
    
    w = dt * pe_em;
    xt = dt * w;
    xs = ds * w;
    
    w = xt * clfr;
    classification = xs * w;
    lab = classification * labeld;

    e(i) = classification * testc;
    cmat{i} = confmat(getlab(xs), lab);
end

gimme_a_name = struct();

gimme_a_name.classifier = classifier;
gimme_a_name.trainSetSizes = size_train_vec;
gimme_a_name.errors = e;
gimme_a_name.errorsMean = mean(e);
gimme_a_name.errorsVar = var(e);
gimme_a_name.confMatrices = cmat;

end

