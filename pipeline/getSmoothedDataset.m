function smoothed = getSmoothedDataset(raw, sigma)

    classes = 10;
    img_per_class = 200;
    
    smoothed = prdataset();
    
    for i=1:classes
        for j=1:img_per_class
            img = getPixels(raw,i,j);
            img_f = imgaussfilt(img,sigma);
            smoothed = im2obj(img_f, smoothed);
        end
    end
    
    smoothed.nlab = raw.nlab;
    smoothed.lablist = raw.lablist;
    smoothed.name = 'Smoothed';
    
end