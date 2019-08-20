// Angled Foot Riser
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

use <../lib/utils.scad>;

width = 40;
depth = 40;
height = 7;
radius = 3;

// foot inset
foot_offset = 3;
foot_inset = 3;

x_skew = -3;
y_skew = 0;

difference() {
    hull() {
        linear_extrude(height + foot_inset)
            offset(r=foot_offset)
                roundrect([width, depth], radius);
        rotate([x_skew, y_skew, 0])
            linear_extrude(0.1)
            roundrect([width, depth], radius);
    }
    // foot cut
    translate([0, 0, height])
        linear_extrude(foot_inset)
            roundrect([width, depth], radius);
}
