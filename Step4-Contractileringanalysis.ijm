run("close all tables jru v1");
open();

title3 = getTitle();

selectWindow(title3);
run("Set Measurements...", "min redirect=None decimal=3");
setSlice(1);
for(i=1;i<nSlices;i++){
	setSlice(i);
	run("Measure");
	selectWindow("Results");
	x = getResult("Max",i-1);
	if(x ==0){
		endtime = i;
		break;
	}
}

Table.rename("Results", "Results-1");
setSlice(1);
run("Analyze Regions", "area centroid equivalent_ellipse");
x1 = getResult("Centroid.X", 0);
y1 = getResult("Centroid.Y", 0);
Initialmajor = getResult("Ellipse.Radius1",0);
Initialminor = getResult("Ellipse.Radius2",0);

Initialringdiameter = (Initialmajor+Initialminor)*0.5;
Initialarea = getResult("Area",0);
print("Time", "Relativeringdiameter","Initialringdiameter","Ringdiameter","Ringangledegree","Ringangledegree2", "Shift","Shiftpercent", "Angle", "x", "x", "x", "x","x", "x", "Edgedistancelarge", "Edgedistancesmall","Ringxposition","topedge","bottomedge");
print(1, 0, 0, 0, 0, 0, 0, 0,0, 0, 0, 0,0,0,0,0);

for (i =2;i<endtime;i++){	
		
setSlice(i);
run("Analyze Regions", "area perimeter circularity centroid equivalent_ellipse");

x2 = getResult("Centroid.X", 0);
y2 = getResult("Centroid.Y", 0);
time = i;
Ringmajor = getResult("Ellipse.Radius1",0);
Ringminor = getResult("Ellipse.Radius2",0);
Ringdiameter = (Ringmajor+Ringminor)*0.5;
Relativeringdiameter = (1-Ringdiameter/Initialringdiameter)*100;
Centroidshift = Math.sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
Centroidshiftpercent = (Centroidshift/Initialringdiameter)*100;
Edgedistancelarge = ((Initialringdiameter+Centroidshift-Ringdiameter)/(Initialringdiameter*2))*100;
Edgedistancesmall = ((Initialringdiameter-Centroidshift-Ringdiameter)/(Initialringdiameter*2))*100;


Ringanglep = (y1-y2)/Centroidshift;
Ringangle = Math.asin(Ringanglep);
Ringangledegree = Math.toDegrees(Ringangle);

Initialtopedge = x1-Initialringdiameter;
topedge = x2-Ringdiameter;
bottomedge = x2+Ringdiameter;
Ringxposition = x2;


if(x2>x1){
	Ringangledegree2 = (-1)*Ringangledegree+90;

	print(time, Relativeringdiameter, Initialringdiameter, Ringdiameter, Ringangledegree, Ringangledegree2,Centroidshift,Centroidshiftpercent, "Add "+round(Ringangledegree2/10) + " Z", Edgedistancelarge, Edgedistancesmall,Ringxposition, topedge,bottomedge);

}
else{
	Ringangledegree2 = Ringangledegree-90;
	print(time, Relativeringdiameter, Initialringdiameter, Ringdiameter, Ringangledegree,Ringangledegree2, Centroidshift,Centroidshiftpercent,"Add "+round(Ringangledegree2/10) + " Z", Edgedistancelarge, Edgedistancesmall,Ringxposition, topedge,bottomedge);


}

}




string = getInfo("log");
filename = getString("enter filename","");
File.saveString(string, "C:/Users/xxx/Desktop/Ringdata/xxx/" + "/"+ filename +".txt"); //this should be modified before running.
if (isOpen("Log")) {
         selectWindow("Log");
         run("Close" );
    }
run("Close All");
