open();
getDimensions(width, height, channels, slices, frames);

title = getTitle();
title1 = replace(title, ".tif", "");
path = getDirectory("image");
newpath = path+"/"+title1;
File.makeDirectory(newpath);
run("Image Sequence... ", "select=[" + newpath + "] dir=[" + newpath + "] format=TIFF");
