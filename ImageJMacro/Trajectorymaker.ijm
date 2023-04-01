open();
setLineWidth(1);
run("Set Measurements...", "min redirect=None decimal=3");
path = getDirectory("image");
title = getTitle();
title1 = replace(title, ".tif", "");
newpath = path+"/ringpath3"+title1+"/";
File.makeDirectory(newpath);
setForegroundColor(1, 224, 254);
setSlice(1);
run("Analyze Regions", "centroid equivalent_ellipse");
Initialmajor = getResult("Ellipse.Radius1",0);
Initialminor = getResult("Ellipse.Radius2",0);
Initialringdiameter = (Initialmajor+Initialminor)*0.5;
x1 = getResult("Centroid.X", 0);
y1 = getResult("Centroid.Y", 0);

newImage("centroids", "RGB white", 600, 600, 1);
drawOval(150,150, 300, 300);
saveAs("tiff",newpath+1);
rename("centroids");

selectWindow(title);

for (i =2;i<121;i++){
	setSlice(i);
	if (i < 16){
	setForegroundColor(0,0, 0);
	}
	else if (i >15 && i<31){
	setForegroundColor(1, 224, 254);
	}
	else if (i >30 && i<46){
	setForegroundColor(214, 255, 0);
	}
	else if (i >45 && i<61){
	setForegroundColor(255, 0, 0);
	}
	else if (i > 60 && i< 76){
	setForegroundColor(0,0, 0);
	}
	else if (i > 75 && i< 91){
	setForegroundColor(245,0, 191);
	}
	else if (i > 90 && i< 106){
	setForegroundColor(0,0, 0);
	}
	else if (i > 105 && i< 121){
	setForegroundColor(0,110, 255);
	}
	selectWindow(title);
	
	run("Measure");
	Segvalue = getResult("Max", 0);
	selectWindow("Results");
	run("Close");
	
	
		if(Segvalue != 0){
		selectWindow(title);
		run("Analyze Regions", "centroid equivalent_ellipse");
		title2 = getTitle();
		selectWindow(title2);
		Ringmajor = getResult("Ellipse.Radius1",0);
		Ringminor = getResult("Ellipse.Radius2",0);
		Ringdiameter =(Ringmajor+Ringminor)*0.5;
		Relativeringdiameter = Ringdiameter/Initialringdiameter*300;
			if (i == 2){
			x3 = x1;
			y3 = y1;
			}
			else {
			x3 = x2;
			y3 = y2;
			}
		x2 = getResult("Centroid.X", 0);
		y2 = getResult("Centroid.Y", 0);
		selectWindow("centroids");
		setLineWidth(1);
		drawOval((x2-x1)/Initialringdiameter*150+300-Relativeringdiameter/2,(y2-y1)/Initialringdiameter*150+300-Relativeringdiameter/2, Relativeringdiameter, Relativeringdiameter);
		//setLineWidth(5);
		//drawLine((x2-x1)/Initialringdiameter*150+300, (y2-y1)/Initialringdiameter*150+300, (x3-x1)/Initialringdiameter*150+300, (y3-y1)/Initialringdiameter*150+300);
		saveAs("tiff",newpath+i);
		rename("centroids");
		selectWindow(title);
		}
		else{
		break;		
		}
}
for (j = i; j<121;j++){
	selectWindow("centroids");
	saveAs("tiff",newpath+j);
	rename("centroids");
	selectWindow(title);
}
