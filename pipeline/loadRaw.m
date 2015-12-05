function images = loadRaw(digits, samples)
  % Load the images in the dataset.
  %
  % images = loadRaw()
  % images ) loadRaw(digits,samples)
  %
  % digits: digits you want to show. it is a vector containing numbers from 0 to 9 (default [0:9])
  % samples: which samples out of 1000 available do you want to show (default [1:40:1000])

  if nargin == 0
    images = prnist([0:9], [1:40:1000]);
  elseif nargin==2
    images = prnist(digits, samples);
  end

end
