edit function w = myTraining(dataset, fraction)
    
    if fraction == 1
        train = dataset;
    else
        train = gendat(dataset,repmat(fraction,1,10));
    end
    
    pipe = proxm([], 'r', 10000)*fisherc*classc;
    
    w = train*pipe;
end