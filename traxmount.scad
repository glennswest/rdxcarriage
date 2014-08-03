// Increase this if your slicer or printer make holes too tight.
extra_radius = 0.1;

// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = m3_nut_od/2 + 0.2 + extra_radius;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;

// OD = outside diameter, corner to corner.
m5_nut_od = 8.1;
m5_nut_radius = m5_nut_od/2 + 0.2 + extra_radius;

m5_head_od = 10.5;
m5_head_radius = m5_head_od/2 + 0.2 + extra_radius;

// Major diameter of metric 5mm thread.
m5_major = 4.85;
m5_radius = m5_major/2 + extra_radius;
m5_wide_radius = m5_major/2 + extra_radius + 0.2;
separation = 40;
thickness = 6;

horn_thickness = 13;
horn_x = 8;

belt_width = 5;
belt_x = 5.6;
belt_z = 7;

m3_nut_slop = 0.25;  // Account for inability for layer height to exactly match nut width.
m3_nut_dia = 6.18 + m3_nut_slop;
m3_nut_r = m3_nut_dia / 2;
m3_nut_thickness = 2.35;
// Extra thickness to help match discrete screw sizes
m3_nut_thickness_extra = m3_nut_thickness + 2.3;
// A bit less extra thickness for tensioner to avoid causing a cutout in the nut trap for the 20x20 grid.
m3_nut_thickness_extra_tensioner = m3_nut_thickness + 1;

m3_screw_slop = 0.1;
m3_screw_dia = 3.0 + m3_screw_slop;
m3_screw_r = m3_screw_dia / 2;
m3_screw_head_slop = 0.22;
m3_screw_head_r = 5.5/2 + m3_screw_head_slop;
m3_screw_head_len = 3.0;  // SHCS
m3_screw_head_gap = 0.5;


module holes()
{

 // Screws for ball joints.
    translate([0, 16, horn_thickness/2]) rotate([0, 90, 0]) #
      cylinder(r=m3_wide_radius, h=60, center=true, $fn=12);
    // Lock nuts for ball joints.
    for (x = [-1, 1]) {
      scale([x, 1, 1]) intersection() {
        translate([horn_x, 16, horn_thickness/2]) rotate([90, 0, -90])
          cylinder(r1=m3_nut_radius, r2=m3_nut_radius+0.5, h=8,
                   center=true, $fn=6);
      }
    }


}


module ears()
{
union() {

    
      // Main body.
      translate([0, 16, -1 * thickness/2])
        cube([27, 18, thickness], center=true);
      // Ball joint mount horns.
      for (x = [-1, 1]) {
        scale([x, 1, 1]) intersection() {
          translate([0, 15, horn_thickness/2])
            cube([separation, 18, horn_thickness], center=true);
          translate([horn_x, 16, horn_thickness/2]) rotate([0, 90, 0])
            cylinder(r1=14, r2=2.5, h=separation/2-horn_x);
        }
      
      }
    }
}

module trax_mount()
{
   difference(){
        ears();
        holes();
        }


}


//trax_mount();
