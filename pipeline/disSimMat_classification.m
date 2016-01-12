function [ gimme_a_name ] = disSimMat_classification(d , size_train_vec , classifier)
%DISSIMMAT_CLASSIFICATION Test classifiers applied directly to
%dissimilarity matrix

% Choose classifier
if strcmp(classifier , 'parzen')
    clfr = parzenddc;
elseif strcmp(classifier , 'knn')
    clfr = knndc([] , 1);
end

% Iterate over size of training set
for i = 1 : length(size_train_vec)
    % Split data into training and test set
    [dt , ds] = getDissimData(d , size_train_vec(i) , size_train_vec(i) , 'random');
    
    % Train and test classifier
    w = dt * clfr;
    classification = ds * w;
    lab = classification * labeld;
    % Calculate error and confusion matrix
    e(i) = classification * testc;
    cmat{i} = confmat(getlab(ds), lab);
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

