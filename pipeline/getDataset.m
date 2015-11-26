function raw = getDataset()
  % It loads the prdatafile, applies preprocessing and convert into
  % a prdataset.
  %
  % raw = getDataset()
  %
  % raw: prdataset with all the images represented by pixels
  %
  % USE 'loadDataset()' TO LOAD AN EXISTING PRDATASET

    raw_dat = loadRaw();

    raw_pre = preprocess(raw_dat);

    raw = prdataset(raw_pre);
end
