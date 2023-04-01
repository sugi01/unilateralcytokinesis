open();
waitForUser("Click 'OK' if the file is correct.");
path = getDirectory("image");
wait(100);
numframes = nSlices/62; //this number should be modified if your slice number is not 31
run("Stack to Hyperstack...", "order=xytzc channels=2 slices=31 frames=numframes display=Color");
Stack.setXUnit("micron");
run("Properties...", "pixel_width=0.183 pixel_height=0.183 voxel_depth=1");
title1 = getTitle();
run("Duplicate...", "duplicate channels=1");
resetMinAndMax();
title2 = getTitle();
selectWindow(title1);
run("Duplicate...", "duplicate channels=2");
resetMinAndMax();
title3 = getTitle();
run("Merge Channels...", "c2=[" + title2 + "] c6=[" + title3 + "] create ignore");

