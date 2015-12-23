function [ ex_data] = extract_feat( data)
%Extract features from data using prtools extractor function
%   ex_data contains a prdataset with extradted features from data

data=im_features(data, 'all');
data_zer=im_moments(data, 'zer', 6);
data_hu=im_moments(data, 'hu');
data_mean=im_mean(data);
data_profile=im_profile(data);
data_stats=im_stat(data);
data_skel=im_skel_meas(data);
data_harris=im_harris(data);

ex_data=[data data_zer data_hu data_mean data_profile data_stats data_skel data_harris];


end

