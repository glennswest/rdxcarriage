use <isothread.scad>;

// Ballnt
BallSize = 7.0;
BallFudge = .1;
Mdiameter = 4.1;
Mheight = 2;
Tball = BallSize + BallFudge;
Cheight = Tball+Mheight;
Zball = Cheight; // - (Tball / 2);
Mzheight = - Mheight+Tball;

difference(){
	cylinder(r=(Tball/2)+5, h=Cheight,$fn = 50);
    
    translate([0,0,Zball]) sphere(Tball,$fn=50);
    translate([0,0,Mzheight]) cylinder(r=Mdiameter/2, h=Mzheight+50//,$fn = 50);
    //translate([0,0,0]) hex_bolt(2,Cheight);
    }