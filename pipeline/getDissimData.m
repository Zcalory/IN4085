function [ dt , ds ] = getDissimData( d , size_train , size_rep , method)
%GETDISSIMDATA Split dissimilarity matrix into training and test set

% If size of training set = size of representation, just split the data
% into training and test sets
if size_train == size_rep
    [dt , ds] = genddat(d , size_train*ones(1,10));    
else
    if strcmp(method , 'random')
        % Choose random objects from each class as representation set
        [dt , ds] = genddat(d , size_train*ones(1,10) , size_rep*ones(1,10));
    elseif strcmp(method , 'forward_feat')
        % Choose objects from each class as representation set using
        % forward feature selection
        [dt1 , ds1] = genddat(d , size_train*ones(1,10));
        crit = 'eucl-s'; % try using other criterias
        w = dt1 * featself([] , crit , size_rep);
        % Transform training and test sets to dissimilarity space
        dt = dt1*w;
        ds = ds1*w;
    elseif strcmp(method , 'indiv_feat')
        % Choose objects from each class as representation set using
        % individual feature selection
        [dt1 , ds1] = genddat(d , size_train*ones(1,10));
        crit = 'eucl-s'; % try using other criterias
        w = dt1 * featseli([] , crit , size_rep);
        % Transform training and test sets to dissimilarity space
        dt = dt1*w;
        ds = ds1*w;
    end

end