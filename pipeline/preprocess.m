function data = preprocess(images)
  process = im_box([],0)*im_box([],0,1)*im_resize([68 68])*im_rotate*im_box([],1,0);
  data = images*process;
end
