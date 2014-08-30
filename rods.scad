use <ballmount.scad>;
use <traxmount.scad>;
use <isothread.scad>;

module rolson_hex_bolt(dia,hi)
// make an ISO bolt with Rolson wrench sizes
//  dia=diameter, 6=M6 etc.
//  hi=length of threaded part of bolt
{
	hhi = rolson_hex_bolt_hi(dia);
	translate([0,0,hhi-0.1])	thread_out(dia,hi+0.1);
	translate([0,0,hhi-0.1])	thread_out_centre(dia,hi+0.1);
}
module dothread(dia,hhi)
{
   
    difference(){
      translate([0,0,0]) cylinder(r=dia/2+1,h=hhi);
	  translate([0,0,-5]) hex_bolt(dia,hhi+.1);
      }
      
}
module rod()
{
    dothread(10,16);
	//difference(){
    //  cylinder(r=7,h=10);
    //  translate([0,0,-1]) dothread(10,12);
    //  }
}

module thread_adapter()
{
     difference(){
        translate([0,0,0]) hex_bolt(10,10);
        translate([0,0,0]) cylinder(r=3.5,h=26);
        }
}

module rod_ends()
{
	union(){
     rotate([180,0,0]) ball_mount();
     translate([0,0,0]) thread_adapter();
     }
 
}

    translate([0,0,13]) rod_ends();
    translate([20,0,0]) rod();
   