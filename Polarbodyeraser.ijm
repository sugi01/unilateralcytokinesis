getDimensions(width, height, channels, slices, frames);
Stack.getPosition(channel, slicenum, framenum);
Stack.setFrame(1);
for (i =framenum;i<= frames;i++){
	Stack.setFrame(i);
	for(j = -3;j<= 3;j++){
		Stack.setSlice(slicenum+j);
		run("Fill","slice");
	}

run("Fill", "slice");
}
run("Select None");