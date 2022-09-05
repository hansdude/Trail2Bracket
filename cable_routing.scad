epsilon=.01;

barrel_d=6;
barrel_r=barrel_d/2;
barrel_h=10;
bracket_h=4;
margin=2;
housing_margin = 3;
housing_i_d = 6;
housing_i_r = housing_i_d/2;
housing_o_r = housing_i_r + housing_margin;
screw_d=2;
screw_r=screw_d/2;
connector_l = barrel_r+margin+housing_o_r;

module epsilon_z() {
	translate([0, 0, -epsilon/2]) children();
}

module bracket() {
	difference() {
		union() {
			cylinder(r=barrel_r, h=barrel_h+bracket_h);
			translate([-barrel_r, 0, barrel_h])
				cube(size=[2*barrel_r, connector_l, bracket_h]);
			translate([0, connector_l, barrel_h]) {
				difference() {
					cylinder(r=housing_o_r, h=bracket_h);
				}
			}
		}
		translate([0, connector_l, barrel_h]) {
			epsilon_z() cylinder(r=housing_i_r, h=bracket_h+epsilon);
		}
		epsilon_z() {
			cylinder(r=screw_r, h=barrel_h+epsilon);
		}
	}
	
}

$fn=100;
bracket();
