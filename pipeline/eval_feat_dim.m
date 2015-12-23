function eval_feat_dim(data)
% Evaluate feature dimensionality using clevalf

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

end