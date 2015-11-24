function show_images(digits, samples)
  %% Show the images in the dataset.
  % digits: digits you want to show. it is a vector containing numbers from 0 to 9 (default [0:9])
  % samples: which samples out of 1000 available do you want to show (default [1:40:1000])
  if nargin == 0
    digits = [0:9];
    samples = [1:40:1000];
  elseif nargin == 1
    samples = [1:40:1000];
  end

  images = prnist(digits, samples);
  figure; show(images);
end
