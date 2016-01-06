function [ ex_data] = extract_feat( data)
%Extract features from data using prtools extractor functions

 % USAGE
  % extract_feat(dataset): Extracts features from dataset and combines them into 
  % a dataset with 389 features 
  %
  % INPUT
  % dataset: prdataset of images
  
  %
  % OUTPUT
  % pixelsMatrix: prdataset with extracted features
 

data_feat=im_features(data, 'all');
data_zer=im_moments(data, 'zer', 6);
data_hu=im_moments(data, 'hu');
data_mean=im_mean(data);
data_profile=im_profile(data);
data_stats=im_stat(data);
data_skel=im_skel_meas(data);
data_harris=im_harris(data);

ex_data=[data_feat data_zer data_hu data_mean data_profile data_stats data_skel data_harris];


end

