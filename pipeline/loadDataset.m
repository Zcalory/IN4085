function set = loadDataset(dataset)
  % It loads an existing prdataset.
  %
  % raw = loadDataset()
  %
  % USE 'getDataset()' IF NO PRDATASET IS AVAILABLE
    
    if dataset == 'r'
        set = load('../dataset/raw.mat');
        set = set.raw;
    end
    
    if dataset == 's'
        set = load('../dataset/smoothed.mat');
        set = set.smoothed;
    end
    
    if dataset == 'v'
        set = load('../dataset/sifted.mat');
        set = set.sifted;
    end
    
end
