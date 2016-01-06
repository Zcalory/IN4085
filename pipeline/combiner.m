function [ w_comb ] = combiner(W_, tst_)
%Combine the classifers in W_ using a series of combining algorithems from
%PRtools

 % USAGE
  % combiner(W, tst): combines the classifers in W and tests them on the
  % test dataset tst. Returns the best perfoming combined classifiers
  %
  % INPUT
  % W_: list of classifiers to combine
  % tst_: test dataset to do perfomance check
  
  %
  % OUTPUT
  % w_comb: best perfoming combined classifier
  
  w1=W_*meanc; % mean combining algorithm
  w2=W_*minc; % min combining algorithm
  w3=W_*prodc; % prod combining algorithm
  w4=W_*medianc; % median combining algorithm
  w5=W_*votec; % vote combining algorithm

  W= [w1; w2; w3; w4;w5];
  E=zeros(1,5);
  for i=1:5
      E(i)=tst_*W(i)*testc();
  end
    who
  [val_min, i_min]=min(E);
  w_comb=W(i_min)
  
  %if i_min==1
  %    fprintf('The best perfoming algorithm is mean \n')
  %else if i_min==2
  %    fprintf('The best perfoming algorithm is mean \n')  
      

end

