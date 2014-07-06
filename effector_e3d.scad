include <configuration.scad>;
use <ballmount.scad>;
use <isothread.scad>;

separation = 44;  // Distance between ball joint mounting faces.
offset = 22;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 18.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 14;  // Hole for the hotend (J-Head diameter is 16mm).
height = 12;
cone_r1 = 2.5;
cone_r2 = 14;


module effector() {
  difference() {
    union() {
      cylinder(r=offset-2, h=height, center=true, $fn=36);
      difference(){
          cylinder(r=offset+20, h=height, center=true, $fn=36);
           rotate([0,0,60]) rotate([0,0,60]) 
                 rotate([0,0,30]) translate([offset+4, 0, 0]) 
                 cylinder(r=5, h=height, center=true, $fn=36);
           for (b = [60:120:359]) rotate([0, 0, b]) {
            rotate([0,0,b]) {
              rotate([0,0,30]) translate([offset-2, 0, 0])
                blank_twin_ball_mount();
                }
              }
          for( b = [20 : 20 : 360]) rotate([0,0,b]) {
              rotate([0,0,b]) translate([offset+8, 0, 0])
              hex_bolt(2,height);
              } 
          }
      for (a = [60:120:359]) rotate([0, 0, a]) {
	        rotate([0, 0, 30]) translate([offset-2, 0, 0])
	        cube([4, 12, height], center=true);
           }
      for (b = [60:120:359]) rotate([0, 0, b]) {
            rotate([0,0,b]) {
              rotate([0,0,30]) translate([offset-2, 0, 0])
                twin_ball_mount();
           }
         }
      }
    translate([0, 0, -height/2])
	cylinder(r1=hotend_radius, r2=hotend_radius+1, h=height+1, $fn=36);
    for (a = [0:120:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
	cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
    }
  }
}

translate([0, 0, height/2]) effector();
