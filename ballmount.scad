use <isothread.scad>;

// Effector
separation = 44;
// Ball Mount
BallSize = 9.53;
BallFudge = .1;
Mdiameter = 4.1;
Mheight = 3.81;
XHeight = 4; // Make it longer
Tball = (BallSize + BallFudge) / 2;
Cheight = Tball+Mheight+4;
Zball = Cheight; 
Mzheight = Zball - Mheight;

module ball_mount(){
difference(){
	cylinder(r=(Tball/2)+5, h=Cheight,$fn = 50);
    
    translate([0,0,Zball]) sphere(Tball,$fn=50);
    translate([0,0,Mheight]) cylinder(h=100,d=Mdiameter,$fn = 50);
    translate([0,0,0]) hex_bolt(2,Cheight);
    }
}


module blank_ball_mount(){
    translate([0,0,-1 * Cheight]) cylinder(r=(Tball/2)+5, h=Cheight*3,$fn = 50);
}

module twin_ball_mount(){
   union()
      { 
      translate([0,0 - (separation / 2), 0]) rotate([0,45,0]) ball_mount();
      translate([0,0 + (separation / 2), 0]) rotate([0,45,0]) ball_mount();
      }
}

module blank_twin_ball_mount(){
   union()
      { 
      translate([0,0 - (separation / 2), 0]) rotate([0,45,0]) blank_ball_mount();
      translate([0,0 + (separation / 2), 0]) rotate([0,45,0]) blank_ball_mount();
      }
}

//ball_mount();