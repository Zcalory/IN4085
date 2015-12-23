clc; close all; 
%% Getting the dataset
% feat_data_1.mat has 24 features extrated using im_features
% feat_data.mat has 45 features extrated using im_features,
%    im_moments(data, 'zer', 6); and im_moments(data, 'hu');
% feat_data_403 has 403 features extrated from most of the extrating
%  functions of prtools

%Option 1: Load from folder
data_feat =load('../dataset/feat_data_389.mat');
data_feat=data_feat.data_feat;

%Option 2:Create new dataset
 %data =loadDataset();

%% Extrating features

%getfeatlab % retrives the labels of features

%data_feat=extract_feat(data)

% 
%save(strcat('../dataset/feat_data_',int2str(N(1,2)),'.mat'),'data_feat')
% this dosent commit if the 
%adaboost takes a classifier and checks missclassification
%The idea about using features is that the images have a lot of data,
%pixels. Most of the pixels in the image don't have valueble information.
% We extract information from the images to get information that can
% be used to classify an object using less data.
%To find the optimal number of features to use

%% Feature dimension

eval_feat_dim(data_feat)
%% Parametric classifiers
wnmc=nmc([]);
wldc=ldc([]);
wqdc=qdc([]);
wfisher=fisherc([]);
wlogl=loglc([]);


% Checking feature dimensionality with clevalf
feat_vec=1:5:size(data(1,:));
lf_qdc=clevalf(data,wqdc,feat_vec, 0.8, 100); 
lf_ldc=clevalf(data,wldc,feat_vec, 0.8, 100);
lf_nmc=clevalf(data,wnmc,feat_vec, 0.8, 100);
lf_fisher=clevalf(data,wfisher,feat_vec, 0.8, 100);
lf_logl=clevalf(data,wlogl,feat_vec, 0.8, 100);
% 
% 
figure()
plote({lf_qdc, lf_ldc, lf_nmc, lf_fisher, lf_logl})

title('Parametric Classifiers')
legend({'QDC', 'LDC', 'NMC', 'Fisher', 'Logl'})



% Non parametric classifiers
wknn=knnc([]);
wparzen=parzenc([]);


lf_knn=clevalf(data,wknn,feat_vec, 0.8, 100); 
lf_parzen=clevalf(data,wparzen,feat_vec, 0.8, 100);
% 
figure()
plote({lf_knn, lf_parzen})
title('Non Parametric Classifiers')
legend({'Knn', 'Parzen'})
%An idea from one of the assistances was to use a loop to randomize the
%features selected, we can use the indices of the random vector to find
%witch features were used (but I didn't understand how to implement this).

%% Feature selection
% Resize the data set choosing the optimal number of features given by
% clevalf - 16 features when using 
[trn, tst]=gendat(data_feat,0.8);
size(trn)
size(tst)

%
[Wb,Rb]=featself(trn,'maha-s',16);
%featsellr is to computational intensive
%featselb dosent perform well on high dimensional space

Wb = setname(Wb,'featf maha-s'); 
disp(+Wb)
% selfeat=round(linspace(1,M(1,2),16)) % generates a linearly spaced vector with the 16 indices for feature selection
% [trn,]=seldat(data_feat,[] ,1:16 ); % Resized dataset with optimal number of features for training
% [tst,]=seldat(data_feat,[] ,1:16); % Resized dataset with optimal number of features for testing
% Mr=size(rdata)
% labels=getfeatlab(data_feat,1)
% size(labels)
% labels(selfeat)

%% Classifiers
%for knn dimensionality is not a problem because 

% Parametric
wnmc=nmc([]);
wldc=ldc([]);
wqdc=qdc([]);
wfisher=fisherc([]);
wlogl=loglc([]);
wknn=knnc([]);
wparzen=parzenc([]);


[W]=trn*Wb*{wnmc,wldc,wqdc,wlogl,wfisher,wknn,wparzen};

Er=(tst*Wb)*W*testc() 


%Traindata with 20 objects of 25
%Test data with 5 objects of 25
%Using the following features (indices): 1,4,7, 10, 13 ,16 ,19, 22, 24 ,27, 30, 33 ,36, 39 ,42 ,45
%Errors using traindata for training and testdata for testing
% NMC      LDC        QDC      Logl       Fisher      Knn    Parzen
%0.7600    0.3600    0.3000    0.3800    0.4200    0.7000    0.6600
%Errors using testdata for training and traindata for testing
%0.6600    0.4350    0.7050    0.5600    0.4900    0.6850    0.7000
%Erros using traindata for both training and testing
%0.6700    0.2650    0.0350    0.1500    0.3200    0.4300    0.6400

%Using the first 16 features - so only from im_features
%Errors using traindata for training and testdata for testing
% NMC      LDC        QDC      Logl       Fisher      Knn    Parzen
%0.7000    0.2200    0.3800    0.3000    0.2600    0.6000    0.6400


%Traindata with 200 objects and testdatawith 50
%Only 16 features from im_features (no concatenation done)
%Error  using traindata for training and testdata for testing:
% NMC      LDC        QDC      Logl       Fisher      Knn    Parzen
%0.6240    0.1280    0.0360    0.1040    0.1720         0    0.5320

% Selecting 16 features using backwards search algorithem
%Only 16 features from im_features (no concatenation done)
%Error  using traindata for training and testdata for testing:
% NMC      LDC        QDC      Logl       Fisher      Knn    Parzen
% 0.5200    0.1600    0.4600    0.7400    0.2000    0.4800    0.6200

% selecting 16 features using forwards search algorithm
% From 389 features using extract_feat
%Error  using traindata for training and testdata for testing:
% NMC      LDC        QDC      Logl       Fisher      Knn    Parzen
%0.6025    0.1550    0.1175    0.1075    0.1725    0.5300    0.5500

%% Confusion matrix on best performing classifier

classification = (tst*Wb)*wldc;
lab = classification*labeld;
cmat = confmat( getlab(tst), lab );

prnist
