function data = preprocess(images)
  process = im_box([],0,1)*im_rotate*im_box([],1,0)*im_resize([50 50]);
  
  data = images*process;
end
