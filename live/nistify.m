function set = nistify(dig)

    set = prdataset();
    set.name = 'LIVE';
    
    for d=1:length(dig)
        
        img = dig{d};
        
        % eliminate red 
        for i=1:size(img,1)
            for j=1:size(img,2)
                color = img(i,j,:);
                
                if isRed(color)
                    img(i,j,:) = [255 255 255];
                end
            end
        end
        
        % turn into grayscale
        img = rgb2gray(img);
        
        % turn into black and white
        img = im2bw(img,0.5);
        
        % invert black and white
        img = imcomplement(img);
        
        img = imresize(img, [68 68]);
        
        set = [set; double(img(:)')];
    end
    
    set.featsize = [68 68];
   
end