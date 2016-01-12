function [ gimme_a_name ] = disSimPE_classification(d , size_train_vec , classifier)
%DISSIMPE_CLASSIFICATION Test classifiers applied to pseudo-euclidean space

% Choose classifier
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

% Iterate over size of training set
for i = 1 : length(size_train_vec)
    [dt , ds] = getDissimData(d , size_train_vec(i) , size_train_vec(i) , 'random');
    % Apply pseud-euclidean embedding to dissimilarity matrix
    w = dt * pe_em;
    xt = dt * w;
    xs = ds * w;
    % Train and test classifier
    w = xt * clfr;
    classification = xs * w;
    lab = classification * labeld;
    % Calculate error and confusion matrix
    e(i) = classification * testc;
    cmat{i} = confmat(getlab(xs), lab);
end

% Save data from a test
gimme_a_name = struct();

gimme_a_name.classifier = classifier;
gimme_a_name.trainSetSizes = size_train_vec;
gimme_a_name.errors = e;
gimme_a_name.errorsMean = mean(e);
gimme_a_name.errorsVar = var(e);
gimme_a_name.confMatrices = cmat;

end

