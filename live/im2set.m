function set = im2set(path,verbose)
    
    if nargin < 2
        verbose = 0;
    end
    
    img = imread(path);
    
    digits = cropdigits(img,verbose);
    
    set = nistify(digits);

end