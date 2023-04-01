run("close all tables jru v1");
open();
path = getDirectory("image");
run("Properties...", "channels=1 slices=31 pixel_width=0.1833333 pixel_height=0.1833333 voxel_depth=1.0000000 frame=[5.70 sec]");
Stack.getDimensions(width, height, channels, slices, frames);
makeRectangle(134, 0, 55, height);
waitForUser("Move the rectangle to the center of the cleavage site.\nClick 'OK' when finished.");
run("Set Measurements...", "min redirect=None decimal=3");
setMinAndMax(120, 1700);
title3 = getTitle();
run("Duplicate...", "duplicate");
title2 = getTitle();
run("3D Project...", "projection=[Brightest Point] axis=Y-Axis slice=1 initial=0 total=360 rotation=10 lower=1 upper=255 opacity=0 surface=100 interior=50 interpolate all");
run("Enhance Contrast", "saturated=0.35");
title4 = getTitle();
path2 = path+title4;
saveAs("tiff",path2);
close(title4);
close(title3);

selectWindow(title2);
run("Gaussian Blur...", "sigma=2 stack");
title = getTitle();
title1 = replace(title, ".tif", "");


newpath = path+"/attenuatedimages"+title1+"/";
File.makeDirectory(newpath);
for (i =1;i< frames;i++){
selectWindow(title);
Stack.setFrame(i);
run("Duplicate...", "duplicate frames=i");
name = getTitle();
name = replace(name,name,"Analyzed");
rename(name);
run("Attenuation Correction", "opening=3 reference=15");
selectWindow("Correction of Analyzed");
saveAs("tiff",newpath+i);
close();
selectWindow("Background of Analyzed");
close();
selectWindow(name);
close();
}
run("Close All");

run("close all tables jru v1");
File.openSequence(newpath);
a = nSlices/31;
run("Stack to Hyperstack...", "order=xyczt(default) channels=1 slices=31 frames=a display=Color");
run("Properties...", "channels=1 slices=31 pixel_width=0.1833333 pixel_height=0.1833333 voxel_depth=1.0000000 frame=[5.70 sec]");
run("Set Measurements...", "min redirect=None decimal=3");
for(i=1; i<nSlices;i++){
setSlice(i);
run("Measure");
}
run("Summarize");
tablerow = Table.size;

wait(300);
maxvalueint = getResult("Max", tablerow-1);
minvalueint = getResult("Min", tablerow-4);
setMinAndMax(minvalueint, maxvalueint);


run("3D Project...", "projection=[Brightest Point] axis=Y-Axis slice=1 initial=0 total=360 rotation=10 lower=1 upper=255 opacity=0 surface=100 interior=50 interpolate all");
run("Enhance Contrast", "saturated=0.35");
newpath2 = newpath+"analyzeddata/";
File.makeDirectory(newpath2);
saveAs("tiff",newpath2+"ring");

run("Close All");