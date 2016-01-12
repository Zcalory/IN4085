function [ dt , ds ] = getDissimData( d , size_train , size_rep , method)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if size_train == size_rep
    [dt , ds] = genddat(d , size_train*ones(1,10));    
else
    if strcmp(method , 'random')
        [dt , ds] = genddat(d , size_train*ones(1,10) , size_rep*ones(1,10));
    elseif strcmp(method , 'forward_feat')
        [dt1 , ds1] = genddat(d , size_train*ones(1,10));
        crit = 'eucl-s'; % try using other criterias
        w = dt1 * featself([] , crit , size_rep);
        dt = dt1*w;
        ds = ds1*w;
    elseif strcmp(method , 'indiv_feat')
        [dt1 , ds1] = genddat(d , size_train*ones(1,10));
        crit = 'eucl-s'; % try using other criterias
        w = dt1 * featseli([] , crit , size_rep);
        dt = dt1*w;
        ds = ds1*w;
    end

end