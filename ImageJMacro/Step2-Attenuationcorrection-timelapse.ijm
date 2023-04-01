open();
getDimensions(width, height, channels, slices, frames);
run("Gaussian Blur...", "sigma=2 stack"); //Gaussian blur
title = getTitle();
title1 = replace(title, ".tif", "");
path = getDirectory("image");
newpath = path+"/attenuatedimages"+title1+"/"; //create new folder in the current folder
File.makeDirectory(newpath);
for (i =1;i< frames;i++){
selectWindow(title);
Stack.setFrame(i);
run("Duplicate...", "duplicate frames=i");//don't touch image J while it is running.
name = getTitle();
name = replace(name,name,"Analyzed");
rename(name);
run("Attenuation Correction", "opening=3 reference=15"); //attenuation correction plug-in required
selectWindow("Correction of Analyzed");
saveAs("tiff",newpath+i);
close();
selectWindow("Background of Analyzed");
close();
selectWindow(name);
close();
}
run("Close All");
