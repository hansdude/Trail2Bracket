epsilon=.01;

barrel_d=8;
barrel_r=barrel_d/2;
barrel_h=6;
bracket_h=2;
margin=2;
housing_i_r = 6;
housing_o_r = 8; //TODO: caclulate
screw_d=3;
screw_r=screw_d/2;
connector_l = barrel_r+margin+housing_o_r;

module epsilon_z() {
	translate([0, 0, -epsilon/2]) children();
}

module bracket() {
	difference() {
		union() {
			cylinder(r=barrel_r, h=barrel_h);
			translate([-barrel_r, 0, barrel_h-bracket_h])
				cube(size=[2*barrel_r, connector_l, bracket_h]);
			translate([0, connector_l, barrel_h-bracket_h]) {
				difference() {
					cylinder(r=housing_o_r, h=bracket_h);
				}
			}
		}
		translate([0, connector_l, barrel_h-bracket_h]) {
			epsilon_z() cylinder(r=housing_i_r, h=bracket_h+epsilon);
		}
		epsilon_z() {
			cylinder(r=screw_r, h=barrel_h+epsilon);
		}
	}
	
}

$fn=100;
bracket();
