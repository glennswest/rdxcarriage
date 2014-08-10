include <configuration.scad>;
include <MCAD/boxes.scad>;

// Belt parameters
belt_width = 6;                    // width of the belt, typically 6 (mm)
belt_thickness = 1.0 - 0.05;       // slightly less than actual belt thickness for compression fit (mm)           
belt_pitch = 2.0;                  // tooth pitch on the belt, 2 for GT2 (mm)
tooth_radius = 0.8;                // belt tooth radius, 0.8 for GT2 (mm)

// Overall clamp dimensions
clamp_width = 18;
clamp_length = 18;
clamp_base = 6;

path_height = belt_width + 1;
clamp_thickness = path_height+clamp_base;

$fn = 40;

clamp_inside_radius = clamp_width/2;
clamp_outside_radius = clamp_inside_radius+belt_thickness;
dTheta_inside = belt_pitch/clamp_inside_radius;
dTheta_outside = belt_pitch/clamp_outside_radius;
pi = 3.14159;

small = 0.01;  // avoid graphical artifacts with coincident faces

m3_nut_slop = 0.25;  // Account for inability for layer height to exactly match nut width.
m3_nut_dia = 6.18 + m3_nut_slop;
m3_nut_r = m3_nut_dia / 2;
m3_nut_thickness = 2.35;
// Extra thickness to help match discrete screw sizes
m3_nut_thickness_extra = m3_nut_thickness + 2.3;
// A bit less extra thickness for tensioner to avoid causing a cutout in the nut trap for the 20x20 grid.
m3_nut_thickness_extra_tensioner = m3_nut_thickness + 1;

m3_screw_slop = 0.2;
m3_screw_dia = 3.0 + m3_screw_slop;
m3_screw_r = m3_screw_dia / 2;
m3_screw_head_slop = 0.22;
m3_screw_head_r = 5.5/2 + m3_screw_head_slop;
m3_screw_head_len = 3.0;  // SHCS
m3_screw_head_gap = 0.5;

module screw(depth)
{
		  main_height = depth;
          translate([0, 0, -30]) cylinder(r=m3_screw_head_r, h=depth, $fn=smooth);
          cylinder(r=m3_screw_r, h=100, $fn=smooth, center = true);
          translate([0, 0, main_height/2-m3_screw_head_len-m3_screw_head_gap])
             cylinder(r=m3_screw_head_r, h=depth, $fn=smooth);
}

module tube(r1, r2, h) {
  difference() {
    cylinder(h=h,r=r2);
    cylinder(h=h,r=r1);
  }
}

module belt_cutout(clamp_radius, dTheta) {
  // Belt paths
  tube(r1=clamp_inside_radius,r2=clamp_outside_radius,h=path_height+small);
  for (theta = [0:dTheta:pi/2]) {
    translate([clamp_radius*cos(theta*180/pi),clamp_radius*sin(theta*180/pi),0]) cylinder(r=tooth_radius, h=path_height+small);
  }
}

module fixed_rounded_box(x,y,z)
{
    translate([x / 2, y / 2, z / 2]) roundedBox([x,y,z], 5, false);
}
module belt_clip(need_hole,clamp_length) {
  difference() {
      fixed_rounded_box(clamp_width, clamp_length, clamp_thickness);
//    cube([clamp_width,clamp_length,clamp_thickness]);
    translate([0,0,clamp_base]) {
      belt_cutout(clamp_inside_radius, dTheta_inside);
      if (need_hole == 1){
         translate([(clamp_width / 2), (clamp_length / 2) + 2, 0]) screw(clamp_thickness);
         }
      translate([(clamp_width - 4), (clamp_length - 7),  -2]) rotate([90,0,0]) screw(clamp_length);
      translate([(clamp_width - 14), (clamp_length - 7), -2]) rotate([90,0,0]) screw(clamp_length);
      //translate([clamp_width,clamp_length,0]) rotate([0, 0, 180])
      //  belt_cutout(clamp_outside_radius, dTheta_outside);
    }
  };
}

belt_clip(1,clamp_length);
translate([18, 30, 0]) rotate([0,0,180])  belt_clip(0,clamp_length - 10);

