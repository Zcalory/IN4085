function digits = cropdigits(img, verbose)
    
    if nargin < 2
        verbose = 0;
    end
    
    lim = 1;
    
    if verbose == 'v'
        figure; 
        imshow(img,'InitialMagnification',50); 
        hold on;
    end
    
    for i=1:4
        [i1,j1] = findcorner(img,lim,'t');
        [i2,j2] = findcorner(img,j1+20,'b');
        
        if verbose == 'v'
            rectangle('Position',[j1,i1,j2-j1,i2-i1],'EdgeColor','b',...
                      'LineWidth',3); hold on;
        end
        
        digits{i} = img(i1:i2,j1:j2,:);
        
        lim = j1+20;
    end
    
end
        