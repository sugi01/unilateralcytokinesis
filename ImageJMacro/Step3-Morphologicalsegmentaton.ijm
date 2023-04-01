run("close all tables jru v1");
run("Image Sequence...");
dir1 = getDir("image");
a = nSlices/31; //this number should be modified if your slice number is not 31.
run("Stack to Hyperstack...", "order=xyczt(default) channels=1 slices=31 frames=a display=Color");
run("Properties...", "channels=1 slices=31 pixel_width=0.1833333 pixel_height=0.1833333 voxel_depth=1.0000000 frame=[5.70 sec]"); //these should also be modified according to your sample info
Stack.setSlice(15);
Stack.setFrame(40);

makeRectangle(134, 2, 55, 175);
waitForUser("Move the rectangle to the center of the cleavage site.\nClick 'OK' when finished.");
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
setMinAndMax(minvalueint, maxvalueint); //this is done to avoid signal saturation after projection


run("Duplicate...", "duplicate");
run("3D Project...", "projection=[Brightest Point] axis=Y-Axis slice=1 initial=0 total=360 rotation=10 lower=1 upper=255 opacity=0 surface=100 interior=50 interpolate all");
run("Enhance Contrast", "saturated=0.35");
waitForUser("Select a Z facing the ring section.(Z ~ 10)\nClick 'OK' when finished.");//if this does not work well, manually duplicate the relevant slice at this point and click OK.
slice1 = getSliceNumber();
run("Duplicate...", "duplicate slices=slice1");
newpath = dir1+"/analyzeddata/"; //new folder created under attenuated image folder
File.makeDirectory(newpath);
saveAs("tiff",newpath+"ring");
run("close all tables jru v1");
wait(10000);
run("Morphological Segmentation");
selectWindow("Morphological Segmentation"); //only three tolerance values will be tested. if this does not work, you need to change value yourself and proceed
//setTool("point");
waitForUser("Click 'Advanced option' and 'OK'.");
call("inra.ijpb.plugins.MorphologicalSegmentation.segment", "tolerance=15.0", "calculateDams=true", "connectivity=6");
call("inra.ijpb.plugins.MorphologicalSegmentation.setDisplayFormat", "Catchment basins");
waitForUser("Click 'OK' when the segmentation results has been shown.");
call("inra.ijpb.plugins.MorphologicalSegmentation.createResultImage");

selectWindow("Morphological Segmentation");
call("inra.ijpb.plugins.MorphologicalSegmentation.segment", "tolerance=10.0", "calculateDams=true", "connectivity=6");
waitForUser("Click 'OK' when the segmentation results has been shown.");
call("inra.ijpb.plugins.MorphologicalSegmentation.createResultImage");

selectWindow("Morphological Segmentation");
call("inra.ijpb.plugins.MorphologicalSegmentation.segment", "tolerance=4.0", "calculateDams=true", "connectivity=6");
waitForUser("Click 'OK' when the segmentation results has been shown.");
call("inra.ijpb.plugins.MorphologicalSegmentation.createResultImage");

waitForUser("Find the best result and check the value of the ring segment. \nIf needed, adjust the tolerance value.\nClick 'OK' when finished.");

run("Select Label(s)");
title3 = getTitle();
selectWindow("Log");
run("Close");
selectWindow(title3);
saveAs("tiff",newpath+"segmentedring"); //your segmented data will be saved as "segmentedring"


