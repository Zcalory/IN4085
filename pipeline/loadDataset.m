function raw = loadDataset()
  % It loads an existing prdataset.
  %
  % raw = loadDataset()
  %
  % USE 'getDataset()' IF NO PRDATASET IS AVAILABLE

    raw = load('../dataset/raw.mat');
    raw = raw.raw;
end
