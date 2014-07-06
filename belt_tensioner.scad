//Post Mounted Belt Tensioner by John Davis 10-14-13

// Which part would you like to make?
part = "All"; // [Wedge: Belt Grip Wedge,Tensioner,Mount, All]

/*[Belt Type]*/
//Standard or GT2
Belt_Type="GT2"; //[Standard,GT2]

/*[Mount Dimensions]*/
//Height of mount
Mount_Height=12;
//Width of mount (parallel with belt)
Mount_Width=16;
//Mounting post hole diameter
Post_Hole=5;
//Distance between adjusting bolts
Adjusting_Separation=10;


/*[Adjusting Bolt and Trapped Nut Dimensions]*/
//Adjusting screw holes
Adjusting_Hole_Diameter=3.2;
//Nut width across flats
Nut_Width=5.5;
//Nut height   
Nut_Height=2.4;
//Additional clearance for nut
Clearance=0.2; 

/*[Printer Settings]*/
//To control the number facets rendered, fine ~ 0.1 coarse ~1.0. 0.3 is fine for home printers.
$fs = 0.3;

/*[Hidden]*/
//leave $fn disabled, do not change
$fn = 0;
//leave $fa as is, do not change
$fa = 0.01;
//padding to insure manifold, ignore
Padding = 0.01; 

Belt0_Min_Thickness=1.2;
Belt0_Max_Thickness=2.4;
Belt0_Teeth_Spacing=5;
Belt0_Tooth_Width=2.3;
Belt0_Height=6.3;
Shift0=0.15;

Belt1_Min_Thickness=0.9;
Belt1_Max_Thickness=1.6;
Belt1_Teeth_Spacing=2;
Belt1_Tooth_Width=1.3;
Belt1_Height=6.1;
Shift1=0.2;

/****************/


print_part();

module print_part() {
	if (part == "Wedge") {
		Belt_Grip_Wedge();
	} else if (part == "Tensioner") {
		Tensioner();
	} else if (part == "Mount") {
		Mount();
	} else {
		Belt_Grip_Wedge();
		Tensioner();
		Mount();
	}
}

module Belt_Grip_Wedge(){
//Belt grip wedge	
if(Belt_Type=="GT2"){
	
	//uncomment for exploded view
	//translate([0,12,Mount_Height/2-Belt1_Height/2-1.7])
	
	
	//uncomment for printing
	translate([0,10,0])
	
	difference(){	
		linear_extrude(height=Belt1_Height+3)
		polygon(points=[[-Belt1_Max_Thickness/2-1,-(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2],[-Belt1_Max_Thickness/2-1.5,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2],[Belt1_Max_Thickness/2+1.5,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2],[Belt1_Max_Thickness/2+1,-(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2]]);
		
		//channel for belt
		difference(){
			translate([Shift1,0,(Belt1_Height+4.5)/2+1.5])
			cube([Belt1_Max_Thickness,4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2*Padding,Belt1_Height+3+Padding],center=true);
			translate([-Belt1_Max_Thickness/2+Belt1_Min_Thickness+Shift1,-2*Belt1_Teeth_Spacing+Belt1_Tooth_Width/2,1.5])
			cube([Belt1_Max_Thickness-Belt1_Min_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Height+1.5+Padding]);
			translate([-Belt1_Max_Thickness/2+Belt1_Min_Thickness+Shift1,-1*Belt1_Teeth_Spacing+Belt1_Tooth_Width/2,1.5])
			cube([Belt1_Max_Thickness-Belt1_Min_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Height+1.5+Padding]);
			translate([-Belt1_Max_Thickness/2+Belt1_Min_Thickness+Shift1,Belt1_Tooth_Width/2,1.5])
			cube([Belt1_Max_Thickness-Belt1_Min_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Height+1.5+Padding]);
			translate([-Belt1_Max_Thickness/2+Belt1_Min_Thickness+Shift1,1*Belt1_Teeth_Spacing+Belt1_Tooth_Width/2,1.5])
			cube([Belt1_Max_Thickness-Belt1_Min_Thickness,Belt1_Teeth_Spacing-Belt1_Tooth_Width,Belt1_Height+1.5+Padding]);
		}

		//bevel for channel opening
		translate([Shift1,0,Belt1_Height+3])
		rotate([90,45,0])
		cube([2,2,4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2*Padding], center=true);
	}
}

if(Belt_Type=="Standard"){
	
	//uncomment for exploded view
	//translate([0,10,Mount_Height/2-Belt0_Height/2-1.7])
	

	//uncomment for printing
	translate([0,10,0])	

	difference(){	
		linear_extrude(height=Belt0_Height+3)
		polygon(points=[[-Belt0_Max_Thickness/2-1,-(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2],[-Belt0_Max_Thickness/2-1.5,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2],[Belt0_Max_Thickness/2+1.5,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2],[Belt0_Max_Thickness/2+1,-(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2]]);
		
		//channel for belt
		difference(){
			translate([Shift0,0,(Belt0_Height+4.5)/2+1.5])
			cube([Belt0_Max_Thickness,3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2*Padding,Belt0_Height+3+Padding],center=true);
			translate([-Belt0_Max_Thickness/2+Belt0_Min_Thickness+Shift0,-3*Belt0_Teeth_Spacing/2+Belt0_Tooth_Width/2,1.5])
			cube([Belt0_Max_Thickness-Belt0_Min_Thickness,Belt0_Teeth_Spacing-Belt0_Tooth_Width,Belt0_Height+1.5+Padding]);
			translate([-Belt0_Max_Thickness/2+Belt0_Min_Thickness+Shift0,-Belt0_Teeth_Spacing/2+Belt0_Tooth_Width/2,1.5])
			cube([Belt0_Max_Thickness-Belt0_Min_Thickness,Belt0_Teeth_Spacing-Belt0_Tooth_Width,Belt0_Height+1.5+Padding]);
			translate([-Belt0_Max_Thickness/2+Belt0_Min_Thickness+Shift0,Belt0_Teeth_Spacing/2+Belt0_Tooth_Width/2,1.5])
			cube([Belt0_Max_Thickness-Belt0_Min_Thickness,Belt0_Teeth_Spacing-Belt0_Tooth_Width,Belt0_Height+1.5+Padding]);

		}

		//bevel for channel opening
		translate([Shift0,0,Belt0_Height+3])
		rotate([90,45,0])
		cube([2.4,2.4,3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2*Padding], center=true);
	}
}
}

module Tensioner(){
//Tensioner
if(Belt_Type=="GT2"){

	//uncomment for printing, leave commented for exploded view
	translate([0,0,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2)/2])
	rotate([90,0,0])
	
	difference(){
		hull(){
			translate([-Adjusting_Separation/2,0,Mount_Height/2])
			rotate([-90,0,0])
			cylinder(r=Mount_Height/2, h=4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2, center=true);
			translate([Adjusting_Separation/2,0,Mount_Height/2])
			rotate([-90,0,0])
			cylinder(r=Mount_Height/2, h=4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2, center=true);
		}
		
		//slot for wedge
		translate([0,1.2,Mount_Height/2-Belt1_Height/2-1.7])
		linear_extrude(height=Belt1_Height+3.4)
		polygon(points=[[-Belt1_Max_Thickness/2-1.2,-(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2-0.2],[-Belt1_Max_Thickness/2-1.7,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2+0.2],[Belt1_Max_Thickness/2+1.7,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2+0.2],[Belt1_Max_Thickness/2+1.2,-(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width)/2-0.2]]);

		//slot for belt
		translate([0,-(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2)/2-Padding,Mount_Height/2])
		cube([Belt1_Max_Thickness+1,4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2+2*Padding,Belt1_Height+1], center=true); 

		//hole for adjusting bolt #1
		translate([-Adjusting_Separation/2,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2+2*Padding)/2,Mount_Height/2])
		rotate([90,0,0])
		cylinder(r=Adjusting_Hole_Diameter/2,h=4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2+2*Padding);
	
		//hole for adjusting bolt #2
		translate([Adjusting_Separation/2,(4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2+2*Padding)/2,Mount_Height/2])
		rotate([90,0,0])
		cylinder(r=Adjusting_Hole_Diameter/2,h=4*Belt1_Teeth_Spacing-Belt1_Tooth_Width+2+2*Padding);
	}
}

if(Belt_Type=="Standard"){

	//uncomment for exploded view, leave commented for printing view
	//translate([0,-8,0])
	
	//uncomment for printing, leave commented for exploded view
	translate([0,0,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2)/2])
	rotate([90,0,0])

	difference(){
		hull(){
		translate([-Adjusting_Separation/2,0,Mount_Height/2])
		rotate([-90,0,0])
		cylinder(r=Mount_Height/2, h=3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2, center=true);
		translate([Adjusting_Separation/2,0,Mount_Height/2])
		rotate([-90,0,0])
		cylinder(r=Mount_Height/2, h=3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2, center=true);
		}
		
		//slot for wedge
		translate([0,1.2,Mount_Height/2-Belt0_Height/2-1.7])
		linear_extrude(height=Belt0_Height+3.4)
		polygon(points=[[-Belt0_Max_Thickness/2-1.2,-(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2-0.2],[-Belt0_Max_Thickness/2-1.7,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2+0.2],[Belt0_Max_Thickness/2+1.7,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2+0.2],[Belt0_Max_Thickness/2+1.2,-(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width)/2-0.2]]);

		//slot for belt
		translate([0,-(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2)/2-Padding,Mount_Height/2])
		cube([Belt0_Max_Thickness+1,4*Belt1_Teeth_Spacing-Belt0_Tooth_Width+2+2*Padding,Belt0_Height+1], center=true);

		//hole for adjusting bolt #1
		translate([-Adjusting_Separation/2,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2+2*Padding)/2,Mount_Height/2])
		rotate([90,0,0])
		cylinder(r=Adjusting_Hole_Diameter/2,h=3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2+2*Padding);
	
		//hole for adjusting bolt #2
		translate([Adjusting_Separation/2,(3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2+2*Padding)/2,Mount_Height/2])
		rotate([90,0,0])
		cylinder(r=Adjusting_Hole_Diameter/2,h=3*Belt0_Teeth_Spacing-Belt0_Tooth_Width+2+2*Padding);
	}
}
}

module Mount(){

translate([0,28,0])

//Mount

	difference(){
		hull(){
			translate([-Adjusting_Separation/2,0,Mount_Height/2])
			rotate([-90,0,0])
			cylinder(r=Mount_Height/2, h=Mount_Width, center=true);
			translate([Adjusting_Separation/2,0,Mount_Height/2])
			rotate([-90,0,0])
			cylinder(r=Mount_Height/2, h=Mount_Width, center=true);
		}

		//post hole
		translate([0,Mount_Width/4,-Padding])
		cylinder(r=Post_Hole/2, h=Mount_Height+2*Padding);

		//cut outs
		translate([Adjusting_Separation/2+Mount_Height/2,Mount_Width/4,-Padding])
		cylinder(r=Adjusting_Separation/2+Mount_Height/2-Mount_Width/4, h=Mount_Height+2*Padding);
		translate([-Adjusting_Separation/2-Mount_Height/2,Mount_Width/4,-Padding])
		cylinder(r=Adjusting_Separation/2+Mount_Height/2-Mount_Width/4, h=Mount_Height+2*Padding);
		translate([0,Mount_Width/2,Mount_Height/2])
		difference(){
			cube([Mount_Width,Mount_Width/2,Mount_Height+2*Padding],center=true);
			translate([0,-Mount_Width/4,0])
			cylinder(r=Mount_Width/4+Padding,h=Mount_Height+4*Padding,center=true);
		}

		//trapped nut #1
		union(){
			translate([-Adjusting_Separation/2,-3*Mount_Width/8,Mount_Height/2])
			rotate([-90,0,0])
			nut();
			translate([-Adjusting_Separation/2-(Nut_Width/2+Clearance)/cos(30),-3*Mount_Width/8,Mount_Height/2])
			cube([(Nut_Width+2*Clearance)/cos(30),Nut_Height+Clearance*2,Nut_Width/2+Clearance]);
		}

		//trapped nut #2
		union(){
			translate([Adjusting_Separation/2,-3*Mount_Width/8,Mount_Height/2])
			rotate([-90,0,0])
			nut();
			translate([Adjusting_Separation/2-(Nut_Width/2+Clearance)/cos(30),-3*Mount_Width/8,Mount_Height/2])
			cube([(Nut_Width+2*Clearance)/cos(30),Nut_Height+Clearance*2,Nut_Width/2+Clearance]);
		}
		
		//hole for adjusting bolt #1
		translate([-Adjusting_Separation/2,-Mount_Width/2-Padding,Mount_Height/2])
		rotate([-90,0,0])
		cylinder(r=Adjusting_Hole_Diameter/2,h=Mount_Width+Padding*2);
		//hole for adjusting bolt #2
		translate([Adjusting_Separation/2,-Mount_Width/2-Padding,Mount_Height/2])
		rotate([-90,0,0])
		cylinder(r=Adjusting_Hole_Diameter/2,h=Mount_Width+Padding*2);
	


	}	
}
/****************/

module nut(){
	cylinder(r=(Nut_Width/2+Clearance)/cos(30),h=Nut_Height+Clearance*2,$fn=6);
}




