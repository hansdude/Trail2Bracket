bb_d=40;
hole_d=6;
hole_h=4;
clip_h=1;
screw_d=4;
taper=1;
cutout=.25;
offset=11;
cable_d=4.5;

thickness=2;
width=30;
height=20;
epsilon=0.01;

module body() {
	difference() {
		cylinder(d=bb_d+thickness*2,h=width,center=true);
		cylinder(d=bb_d,h=width+epsilon,center=true);
		translate([0, height/2, -width/2-epsilon/2])
			cube(size=[100, 100, width+epsilon]);
		rotate([180, 0, 0])
			translate([0, height/2, -width/2-epsilon/2])
			cube(size=[100, 100, width+epsilon]);
		rotate([0, 180, 0])
			translate([-epsilon, -50, -width/2-epsilon/2])
			cube(size=[100, 100, width+epsilon]);
		translate([bb_d/2-thickness, 0, 0])
			rotate([0, 90, 0])
			cylinder(d=screw_d, h=thickness*2);
	}
}
module clip() {
	translate([bb_d/2, 0, 0])
	rotate([0, -90, 0]) {
		difference() {
			union() {
				cylinder(d1=hole_d,d2=hole_d-taper,h=hole_h);
				translate([0, 0, hole_h-clip_h])
				cylinder(d1=hole_d,d2=hole_d-taper,h=clip_h);
			}
			translate([0, 0, -epsilon/2])
			cylinder(d1=screw_d,d2=screw_d-taper,h=hole_h+epsilon);
			translate([-(hole_d+epsilon)/2, 0, -epsilon/2])
				cube(size=[hole_d+epsilon, cutout, hole_h+epsilon]);
			rotate([0, 0, 90])
				translate([-(hole_d+epsilon)/2, 0, -epsilon/2])
				cube(size=[hole_d+epsilon, cutout, hole_h+epsilon]);
		}
	}
}
module knob() {
	translate([bb_d/2, 0, 0])
		rotate([0, -90, 0])
		cylinder(d=hole_d,h=hole_h);
}
module connector() {
	module tube(big_r, r, angle) {
		rotate([0, 0, -angle/2])
			rotate_extrude(angle=angle) {
				translate([big_r+r, 0, 0])
					circle(r=r);
			}
	}
	angle=2*asin(height/bb_d);
	translate([0, 0, offset])
		difference() {
			tube(big_r=bb_d/2, r=cable_d/2+thickness, angle=angle);
			tube(big_r=bb_d/2+thickness, r=cable_d/2, angle=angle+epsilon);
		}
}
module bracket() {
	body();
	clip();
	connector();
}

$fn=100;
bracket();
