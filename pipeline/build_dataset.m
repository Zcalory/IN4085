function prdata = build_dataset(images)
    
    class = 1:10;
    img_per_class = 200;
    
    dataset = [];
    
    for i=1:length(class)
        for j=1:img_per_class
            im = images{i*j};
            dataset = [dataset; im(:)' class(i) ];
        end
    end

    prdata = prdataset(dataset(:,1:length(im(:))), dataset(:,length(im(:))+1));
end