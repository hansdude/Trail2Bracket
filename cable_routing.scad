epsilon=.01;

barrel_d=6;
barrel_r=barrel_d/2;
barrel_h=10;
bracket_h=4;
housing_margin = 3;
housing_i_d = 5;
housing_i_r = housing_i_d/2;
housing_o_r = housing_i_r + housing_margin;
screw_d=3.5;
screw_r=screw_d/2;
connector_l = barrel_r+housing_o_r;
notch_l=2;
notch_w=2;
notch_overlap=(barrel_r-screw_r)/2;

module epsilon_z() {
	translate([0, 0, -epsilon/2]) children();
}

module bracket() {
	difference() {
		union() {
			cylinder(r=barrel_r, h=barrel_h+bracket_h);
			translate([-barrel_r, 0, barrel_h])
				cube(size=[2*barrel_r, connector_l, bracket_h]);
			translate([0, connector_l, barrel_h])
				cylinder(r=housing_o_r, h=bracket_h);
		}
		translate([0, connector_l, barrel_h])
			epsilon_z()
			cylinder(r=housing_i_r, h=bracket_h+epsilon);
		epsilon_z()
			cylinder(r=screw_r, h=barrel_h+bracket_h+epsilon);
	}
	
}

$fn=100;
bracket();
	translate([-notch_w/2, barrel_r-notch_overlap, 0])
			cube(size=[notch_w, notch_l+notch_overlap, barrel_h]);
