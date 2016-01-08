function featured = myFeaturing(image)

out = [];
%smoothed = prdataset();

N = size(image,1);

for i=1:N
    image_boxed = preprocess(image(i,:));
    image_boxed = data2im(image_boxed);
    image_boxed = im_gauss(image_boxed,.6,.6);
    
    
    %smoothed = im2obj(img_f, smoothed);       

    
    img = single( image_boxed );
    [~,sift] = vl_dsift(img, 'size', 8, 'Step', 5);
    out(i,:) = double(sift(:))';
  
end

    featured = prdataset(out);
    %featured = smoothed;
end