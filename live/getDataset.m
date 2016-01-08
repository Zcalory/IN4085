function gsnist = getDataset()
	
    datapath = dir('Dataset');
    
    gsnist = prdataset();
                        
    for i=1:length(datapath)
        
        label = [];
        
        file = datapath(i);
        
        if file.isdir == 1
            continue;
        end
        
        data = strsplit(file.name,'_');
        
        id = data{1};
        lab = data{2};
        
        disp(['Processing image: ' id]);
        
        img = im2set(fullfile('Dataset',file.name),'NOVERBOSE');
        
        drawnow;
        
        for j=1:4
            label = [label; ['digit_' lab(j)] ];
        end
        
        disp(label);
        
        img = setlabels(img,label);
        
        figure; show(img);
        
        gsnist = [gsnist; img];
        
        pause(1); close all;
    end
    
    
    gsnist_raw = prdataset();
    
    dioporco = [2,3,4,9,0,5,7,8,1,6];

    for i=1:classes
        
        tmp = seldat(gsnist,i);
        tmp = setlabels(tmp, repmat( ['digit_' num2str(dioporco(i))], tmp.objsize, 1 ) );
        
        gsnist_raw = [gsnist_raw; tmp];
    end
    
    
    
end
