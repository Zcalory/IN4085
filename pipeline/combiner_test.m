%Combining testing
clc; close all; 

data_feat =load('../dataset/feat_data_new389.mat');
data_feat=data_feat.data_feat;



[trn, tst]=gendat(data_feat,0.8);
[Wb,Rb]=featself(trn,ldc,101);

trn=trn*Wb;
wldc=trn*ldc([]);
wqdc=trn*qdc([]);
wlogl=trn*loglc([]);

w=combiner([wldc; wqdc; wlogl], tst*Wb);
