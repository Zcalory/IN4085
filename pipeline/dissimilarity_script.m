clear all, close all, clc

%%
% Select number of objects per class
samples = 1 : 2 : 1000;
% Always load all the classes
data_raw = loadRaw(0:9 , samples);
data_pre = preprocess(data_raw);
data = prdataset(data_pre);
%%

%%% TEST CLASSIFIERS APPLIED DIRECTLY TO DISSIM MATRIX (knn and parzen)
%%% WRT DIFFERENT DISSIMILARITY REPRESENTATIONS

size_train_vec = [200 , 250 , 300 , 350 , 400];
%% Build dissimilarity space - euclidean distance mapping
prox_type = 'distance';
prox_param = 1;
d = data * proxm(data , prox_type , prox_param);
%visualizeDissimMat(d); % takes too long for large matrices

DisEucDistKnn = disSimMat_classification(d , size_train_vec , 'knn');
DisEucDistParzen = disSimMat_classification(d , size_train_vec , 'parzen');


%%% TEST CLASSIFIERS APPLIED TO PSEUDOEUCLIDEAN DISSIMILARITY SPACE

%% Build dissimilarity space - non-euclidean mappings

prox_type = 'minkowski';
d = data * proxm(data , prox_type , []);

%TODO: make PE classifiers work, there's a problem with some DisTools functions
size_train_vec = 20;
DisMinkKnn = disSimPE_classification(d , size_train_vec , 'nmcpe');


%%% TEST CLASSIFIERS APPLIED TO TRANSFORMED DISSIMILARITY SPACE
%%
prox_type = 'distance';
prox_param = 1;
d = data * proxm(data , prox_type , prox_param);

size_train_vec = [200 , 250 , 300 , 350 , 400];
size_rep_vec = [10 , 50 , 80 , 100 , 150];


test = disSimSpace_classification(d , size_train_vec , size_rep_vec , 'forward_feat' , 'ldc');


