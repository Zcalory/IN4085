clc; close all; 

%% Getting dataset
%Option 1: Load from folder
%data_feat =load('../dataset/feat_data.mat');
%data_feat=data_feat.data_feat;

%Option 2:Create new dataset
 data = getDataset();

%% Extrating features
data_feat=im_features(data, 'all');
%getfeatlab % retrives the labels of features


data_zer=im_moments(data, 'zer', 6);
data_hu=im_moments(data, 'hu');
% data_feat=[data_feat moments_zer moments_hu];
% size(data_feat)
% 
% save('../dataset/feat_data.mat','data_feat')

%adaboost takes a classifier and checks missclassification
%The idea about using features is that the images have a lot of data,
%pixels. Most of the pixels in the image don't have valueble information.
% We extract information from the images to get information that can
% be used to classify an object using less data.
%To find the optimal number of features to use

%% Feature selection
% Parametric
wnmc=nmc([]);
wldc=ldc([]);
wqdc=qdc([]);
wfisher=fisherc([]);
wlogl=loglc([]);


%An idea from one of the assistances was to use a loop to randomize the
%features selected, we can use the indices of the random vector to find
%witch features were used (but I didn't understand how to implement this).

%% Checking feature dimensionality with clevalf
% feat_vec=[4,8,16,30,40,48,52];
% lf_qdc=clevalf(data_feat,wqdc,feat_vec, 0.8, 100); 
% lf_ldc=clevalf(data_feat,wldc,feat_vec, 0.8, 100);
% lf_nmc=clevalf(data_feat,wnmc,feat_vec, 0.8, 100);
% lf_fisher=clevalf(data_feat,wfisher,feat_vec, 0.8, 100);
% lf_logl=clevalf(data_feat,wlogl,feat_vec, 0.8, 100);
% 
% 
% figure()
% plote(lf_qdc, 'noapperror','b')
% hold on
% plote(lf_ldc, 'noapperror','y')
% hold on
% plote(lf_nmc,'noapperror','r')
% hold on 
% plote(lf_fisher,'noapperror','c')
% hold on
% plote(lf_logl,'noapperror','m')
% 
% title('Parametric Classifiers')
% legend('QDC', 'LDC', 'NMC', 'Fisher', 'Logl')



% Non parametric
wknn=knnc([]);
wparzen=parzenc([]);


% lf_knn=clevalf(data_feat,wknn,feat_vec, 0.8, 100); 
% lf_parzen=clevalf(data_feat,wparzen,feat_vec, 0.8, 100);
% 
% figure()
% plote(lf_knn,'noapperror','r')
% hold on
% plote(lf_parzen,'noapperror','b')
% legend('Knn', 'Parzen')

M=size(data_feat)

% Resize the data set choosing the optimal number of features given by
% clevalf - 16 features

selfeat=round(linspace(1,M(1,2),16)) % generates a linearly spaced vector with the 16 indices for feature selection
[traindata,]=seldat(data_feat,[] ,1:16,{1:20,1:20,1:20,1:20,1:20,1:20,1:20,1:20,1:20,1:20} ); % Resized dataset with optimal number of features for training
[testdata,]=seldat(data_feat,[] ,1:16,{21:25,21:25,21:25,21:25,21:25,21:25,21:25,21:25,21:25,21:25} ); % Resized dataset with optimal number of features for testing
Mr=size(rdata)
labels=getfeatlab(data_feat,1)
size(labels)
labels(selfeat)

%% Classifiers
%for knn dimensionality is not a problem because 

% Parametric
wnmc=nmc([]);
wldc=ldc([]);
wqdc=qdc([]);
wfisher=fisherc([]);
wlogl=loglc([]);

[W]=traindata*{wnmc,wldc,wqdc,wlogl,wfisher,wknn,wparzen };

Er=testdata*W*testc() 

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

%Using the first 16 features - so only
%Errors using traindata for training and testdata for testing
% NMC      LDC        QDC      Logl       Fisher      Knn    Parzen
%0.7000    0.2200    0.3800    0.3000    0.2600    0.6000    0.6400




