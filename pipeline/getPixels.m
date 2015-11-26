function [pixelsMatrix] = getPixels(dataset, class, image)
  % Convert images to matrix of pixels
  %
  % USAGE
  % getPixels(image): converts the image into a matrix of pixel values
  % getPixels(dataset, class, image): converts the image belonging to
  % the specified class into a matrix of pixel values.
  %
  % INPUT
  % dataset: prdataset of images
  % class: number of the class of the image [0:10]
  % image: number of the image inside the class [0:200]
  %
  % OUTPUT
  % pixelsMatrix: matrix representing the image.
  %
  %
  % NOTE: you can use show(pixelsMatrix) to show the image.

    if nargin == 1
        pixelsMatrix = data2im(dataset);
        return;
    end

    img = seldat(dataset, class, [], image);

    pixelsMatrix = data2im(img);
end
