function [ ] = visualizeDissimMat( d )
%VISUALIZEDISSIMMAT Show dissimilarity space as an image and dataset in 2D

% Visualize the data using various methods - good for the report
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

