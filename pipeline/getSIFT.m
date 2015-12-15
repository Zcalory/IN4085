function sifted = getSIFT(set)

    classes = 10;
    img_per_class = 200;
    
    sifted = prdataset();
    
    for i=1:classes
        for j=1:img_per_class

            disp(['PROCESSING IMAGE: ' num2str(j)]);

            img = single( getPixels(set,i,j) );
            [~,sift] = vl_dsift(img, 'size', 8, 'Step', 5);
            sifted = [sifted; double( sift(:)' )];
        end
    end
    
    sifted.nlab = set.nlab;
    sifted.lablist = set.lablist;
    sifted.name = 'SIFT';

end