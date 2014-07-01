

// Ball Mount
BallSize = 7.0;
BallFudge = .1;
Mdiameter = 4.1;
Mheight = 2;
Tball = BallSize + BallFudge;
Cheight = Tball*1.5+Mheight;
Zball = Cheight; // - (Tball / 2);
Mzheight = - (2*Mheight)+Tball;

difference(){
	cylinder(r=(Tball/2)+4, h=Cheight,$fn = 50);
    
    translate([0,0,Zball]) sphere(Tball,$fn=50);
    translate([0,0,Mzheight]) cylinder(r=Mdiameter, h=Mzheight,$fn = 50);
    }