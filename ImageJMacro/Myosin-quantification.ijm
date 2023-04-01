run("close all tables jru v1");
run("Set Measurements...", "integrated redirect=None decimal=3");
waitForUser("Open segmentation results");
open();
run("8-bit");
run("Make Binary", "method=Otsu background=Dark calculate black");
title1 = getTitle();
run("Duplicate...", "duplicate");
title2 = getTitle();
run("Dilate","stack");
run("Dilate","stack");
run("Dilate","stack");
run("Dilate","stack");
setAutoThreshold("Otsu dark no-reset stack");
run("Analyze Particles...", "size=100-Infinity add stack");
ROInum = roiManager("count");

selectWindow(title1);
run("Erode", "stack");
run("Erode", "stack");
run("Erode", "stack");
run("Erode", "stack");

setAutoThreshold("Otsu dark no-reset stack");
run("Analyze Particles...", "size=100-Infinity add stack");
ROInum2 = roiManager("count");
waitForUser("Open ring data");
open();

for(i=1; i< ROInum2 ;i++){
roiManager("Select", i);
run("Measure");
}
for(i=1; i<ROInum-1 ; i++){
	Ring = getResult("IntDen",i);
    Ring1 = Array.concat(Ring1, Ring);
}
for(i=ROInum-1; i<ROInum2-1 ; i++){
	Inside = getResult("IntDen",i);
    Inside1 = Array.concat(Inside1, Inside);
}
for(i =1;i<ROInum2-ROInum+1;i++){
	Subtracted = Ring1[i]-Inside1[i];
	Subtracted1 = Array.concat(Subtracted1,Subtracted);
}
Table.create("table1");
Table.setColumn("Ringintensity", Ring1);
Table.setColumn("Bg", Inside1);
Table.setColumn("Subtracted", Subtracted1);


filename = getString("enter filename","");
saveAs("Results", "C:/Users/xxx/Desktop/xxx/" + "/"+ filename +".csv");
close("ROI Manager");
run("Close All");

