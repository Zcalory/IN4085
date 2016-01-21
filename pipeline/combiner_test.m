%Combining testing
clc; close all; 

data_feat =load('../dataset/feat_data_new101.mat');
data_feat=data_feat.data_feat;



[trn, tst]=gendat(data_feat,0.8);


wldc=trn*ldc([]);
wqdc=trn*qdc([]);
wlogl=trn*loglc([]);



w=combiner([wldc, wqdc, wlogl], tst);
