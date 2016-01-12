function [ ] = visualizeDissimMat( d )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

figure;
imagesc(+d);
title('Dissimilarity data as an image')
figure;
subplot 121
scatterd(d * pca(d , 2));
title('Dissimilarity data in PCA space')
subplot 122
scatterd(d * mds(d , 2));
title('Dissimilarity data scaled with MDS')

end

