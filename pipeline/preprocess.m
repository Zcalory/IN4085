function data = preprocess(images)
  process = im_box([],0,1)*im_rotate*im_box([],1,0);
  data = images*process;
end
