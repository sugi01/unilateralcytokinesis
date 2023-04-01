open();
run("Properties...", "pixel_width=0.183333 pixel_height=0.183333 voxel_depth=1");
Stack.setSlice(4);
resetMinAndMax();
waitForUser;
dir1 = getDir("image");
title = getTitle();
title1 = replace(title, ".tif", "");
newpath = dir1+"/projectionperpendicular"+title1+"/";
File.makeDirectory(newpath);

run("Duplicate...", "duplicate frames=1-120");
img1 = getTitle();
angle = getString("enter the value for Z. Enter negative value for Reduce", 0);
angle2 = parseInt(angle);
angle3 = angle2+9;
if(abs(angle2) >= 5 && abs(angle2) <= 13){
Stack.getDimensions(width, height, channels, slices, frames);
run("Duplicate...", "duplicate");
img2 = getTitle();
makeRectangle(1,1,width,height);
for (i =1;i<= frames;i++){
Stack.setFrame(i);
	for(j = 1;j<= slices/2-3;j++){
	Stack.setSlice(j);
	run("Fill", "slice");

}}
saveAs("tiff",newpath+"topmasked");
img4 = getTitle();

selectWindow(img1);
run("Duplicate...", "duplicate");
img3 = getTitle();
makeRectangle(1,1,width,height);
for (i =1;i<= frames;i++){
Stack.setFrame(i);
	for(j = slices/2+3; j<= slices+1;j++){
	Stack.setSlice(j);
	run("Fill", "slice");

}}
saveAs("tiff",newpath+"bottommasked");
img5 = getTitle();
}
else{
Stack.getDimensions(width, height, channels, slices, frames);
run("Duplicate...", "duplicate");
img2 = getTitle();
makeRectangle(1,1,width,height/2.1);
for (i =1;i<= frames;i++){
Stack.setFrame(i);
	for(j = 1;j<= slices;j++){
	Stack.setSlice(j);
	run("Fill", "slice");

}}
saveAs("tiff",newpath+"topmasked");
img4 = getTitle();

selectWindow(img1);
run("Duplicate...", "duplicate");
img3 = getTitle();
makeRectangle(1,height/1.8,width,height/2.1);
for (i =1;i<= frames;i++){
Stack.setFrame(i);
	for(j = 1;j<= slices;j++){
	Stack.setSlice(j);
	run("Fill", "slice");

}}
saveAs("tiff",newpath+"bottommasked");
img5 = getTitle();

}

selectWindow(img4);
run("Select None");
run("3D Project...", "projection=[Brightest Point] axis=X-Axis slice=1 initial=0 total=360 rotation=10 lower=1 upper=255 opacity=0 surface=100 interior=50 interpolate all");
img6 = getTitle();
Stack.getDimensions(width, height, channels, slices, frames);
if(angle3 > 0){
angle4 = angle3;
setSlice(angle4);
wait(100);
run("Duplicate...", "duplicate slices=angle4");
saveAs("tiff",newpath+"oriented1");
}
else{
	angle4 = slices+angle3;
	setSlice(angle4);
wait(100);
run("Duplicate...", "duplicate slices=angle4");
saveAs("tiff",newpath+"oriented1");
}
selectWindow(img6);

if(angle4 <=18){
angle5 = 18+angle4;
setSlice(angle5);
wait(500);
run("Duplicate...", "duplicate slices=angle5");
saveAs("tiff",newpath+"oriented2");
}
else{
	angle5 = angle4-18;
	setSlice(angle5);
	wait(500);
	run("Duplicate...", "duplicate slices=angle5");
	saveAs("tiff",newpath+"oriented2");
}


selectWindow(img5);
run("Select None");
run("3D Project...", "projection=[Brightest Point] axis=X-Axis slice=1 initial=0 total=360 rotation=10 lower=1 upper=255 opacity=0 surface=100 interior=50 interpolate all");
img7 = getTitle();
Stack.getDimensions(width, height, channels, slices, frames);
if(angle3 > 0){
angle6 = angle3;
setSlice(angle6);
wait(100);
run("Duplicate...", "duplicate slices=angle6");
saveAs("tiff",newpath+"oriented3");
}
else{
	angle6 = slices+angle3;
	setSlice(angle6);
wait(100);
run("Duplicate...", "duplicate slices=angle6");
saveAs("tiff",newpath+"oriented3");
}

selectWindow(img7);
if(angle6 <=18){
angle7 = 18+angle6;
setSlice(angle7);
wait(500);
run("Duplicate...", "duplicate slices=angle7");
saveAs("tiff",newpath+"oriented4");
}
else{
	angle7 = angle6-18;
	setSlice(angle7);
	wait(500);
	run("Duplicate...", "duplicate slices=angle7");
	saveAs("tiff",newpath+"oriented4");
}