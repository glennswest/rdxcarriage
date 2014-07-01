// Y-belt retainer/tensioner
// May 2012 John Newman
// June 2012 Luis Andrade

// This parameter deterimes how far the belt is held above the deck
dRise = 0;				// Added to the depth to make the belt run horizontal

// Belt dimensions - These are for T5
//tBase = 1.5;			// Thickness of belt base
//tFull = 2.7;			// Thickness of Belt at teeth
//wTooth = 2.6;			// Width of tooth (not actual, req)
//wSpace = 2.4;			// Width of space

// Belt dimensions - These are for T2.5
//tBase = 1.25;			// Thickness of belt base
//tFull = 2.0;			// Thickness of Belt at teeth
//wTooth = 1.4;			// Width of tooth (not actual, req)
//wSpace = 1.1;			// Width of space

// Belt dimensions - These are for GT2 2mm
tFull = 1.6;			// Thickness of Belt at teeth
tTooth = 0.8;			// Thickness of Belt teeth
tBase = tFull - tTooth;	// Thickness of belt base
wTooth = 2.0;			// GT Belt pitch
wSpace = 0.0;			// Width of space (not used in GT2)

// Defines the belt to be used
// 0 = T5
// 1 = T2.5
// 2 = GT2
belt = 2;
wBelt = 6.1;				// Width of belt

// Misc params
wHex = 6.9;				// Width of trap for hex nut
dHex = 2.5;				// Depth of trap for hex nut
rM3 = 1.7;				// Radius of M3 bolt hole
sDrop = wHex/2-0.5; 	// Driver screw drop from base of slider
Adjust = 0.5;			// Spacing for things to fit inside other things!
pWidth = 9;				// Screw platform width

// Base parameters
bwExt = 15;				// Widest part of base
bwInt = 15;				// inside width, where slider goes
blExt = 30;				// Overall length of base
blHed = 6;				// Head of base whch takes the strain !
bdExt = 12;			// This included a minimum floor thickness of 2mm (?)
bRoof = 2;			// The thickness of the roof which holds the slider in
bFloor = 2;				// The thickness of the floor under the slider (minimum)
bdSoc = bdExt-(bRoof+bFloor);		// 'Socket' depth for slider to go in

// Slider parameters
swMax = bwInt - Adjust;		// Wide part of slider
sdMax = bdSoc-Adjust;		// Height of slider

lBelt = blExt*2;			// Length of a bit of belt!
rMsk = blExt/3 ;			// Radius of part of mount masking...
resol = 10;				// Resolution of the holes

//=====================================================

rotate([0,0,90]) {
	// Bottom part
	difference() {
		translate([0, bwExt+pWidth+5, bdExt/2+dRise]) 
		rotate([0, 180, 180])
		basepart();

		translate([0,bwExt+pWidth+5, 10+dRise-(2-tFull)])
		cube([blExt+10, bwExt+pWidth+12, bdExt], center = true);
	}

	// Upper part
	difference() {
		translate([0, -1*(bwExt+pWidth+5), bdExt/2]) 
		basepart();

		translate([0,-1*(bwExt+pWidth+5), bdExt+1.9])
		cube([blExt+10, bwExt+pWidth+12, bdExt], center = true);
	}

	// One piece vertical
	//translate([0, 20, blExt/2])
	//rotate([0, 90, 90])
	//basepart();

	// Slider
	translate([0,0,(sdMax)/2]) 
	rotate([0,180,0]) 
	sliderpart();
}

//=====================================================

module sliderpart() {
	difference() {
		cube([blExt-blHed,swMax,sdMax],center=true);

		// Make a hole for the bolt end
		translate([(blExt-blHed)/2-2,0,(sdMax/2)-sDrop]) 
		rotate([30,0,0]) 
		rotate([0,90,0]) 
		cylinder(h = 10, r = rM3, $fn=resol);

		// Make a fracture to cause fill
		translate([(blExt-blHed)/2-4.2,0,(sdMax-tFull)/2+1]) 
		cube([0.05,swMax-4.4,sdMax],center=true) ;

		// Finally indent for belt
		translate([-lBelt/2,-wBelt/2,-sdMax/2-0.1]) 
		if (belt == 2)
			belt_gt2();
		else
			belt();
	}
}

//=====================================================

module basepart() {
	union() {
		difference() {
			translate([0,0,dRise/2]) 
			cube([blExt,bwExt,bdExt+dRise],center=true);

			// Remove the space for the slider
			translate([-blHed,0,(bFloor-bRoof)/2]) 
			cube([blExt,bwInt,bdSoc],center=true);

			// Remove a hole for the bolt
			translate([(blExt/2-(blExt+blHed-1)),0,bFloor+sDrop-bdExt/2]) 
			rotate([30,0,0]) 
			rotate([0,90,0]) 
			cylinder(h = blExt+blHed,r = rM3, $fn=resol);

			// An indentation for the bolt head
			translate([(blExt/2)-(blHed+5-dHex),0,bFloor+sDrop-bdExt/2]) 
			rotate([30,0,0]) 
			rotate([0,90,0]) 
			cylinder(5,wHex/2,wHex/2,$fn=6);

			// A slot for the belt to come through
			translate([blExt/2,0,(bdExt-tFull)/2-bRoof-0.1]) 
			cube([blExt+blHed,wBelt+2,tFull+0.1],center=true);
		}

		for (i = [-1:1])
		if (i != 0) {
			translate([0,i*(bwExt/2 + (pWidth/2-0.01)),(bdExt/2-bdExt/2)+dRise/2]) 
			rotate([180,0,0])
			screwmount() ;
		}
	}
}

//=====================================================

module belt_gt2() {
	cube([lBelt,wBelt,tBase]) ;
	for (inc = [0:wTooth:lBelt-wTooth]) 
		translate([inc,wBelt,tBase]) 
		rotate([90,0,0])
		cylinder(h = wBelt, r=tTooth, $fn=20);
}

//=====================================================

module belt() {
	cube([lBelt,wBelt,tBase]) ;
	for (inc = [0:(wTooth+wSpace):lBelt-wTooth]) 
		translate([inc,0,tBase-0.01]) 
		cube([wTooth,wBelt,(tFull-tBase)]) ;
}

//=====================================================

module screwmount() {
	difference() {
		cube([blExt,pWidth,bdExt+dRise],center=true);

		// Bolt holes (not passthrought to generate bridge)
		for (i = [-1:1]) {
			if (i != 0)
			translate([i*(blExt-pWidth)/2,0,-(bdExt/2+dRise/2)-0.1]) 
			rotate([0,0,30]) 
			cylinder(h = bdExt+dRise-dHex, r = rM3,$fn=resol);
		}

		// Nut traps
		for (i = [-1:1]) {
			if (i != 0)
			translate([i*((blExt-pWidth)/2), 0, (bdExt/2-dHex)+dRise/2]) 
			rotate([0,0,30]) 
			cylinder(h=dHex+0.1, r=wHex/2,$fn=6);
		}
	}
}
