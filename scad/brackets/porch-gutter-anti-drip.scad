// Porch Gutter Anti-Drip for Small Improvised Gutter
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

use <../lib/utils.scad>;

gutter_width = 25;
gutter_inner_height = 25;
gutter_thickness = 1;

thickness = 3;
width = 5;
clip_overlap = 3;

total_width = gutter_width + thickness*2;
total_height = gutter_inner_height + thickness*2;
cutout_width = gutter_width - clip_overlap;

module profile() {
    difference() {
        square([total_width, total_height]);
        translate([thickness, thickness])
            square([gutter_width, gutter_inner_height]);
        translate([thickness, gutter_inner_height+thickness, 0])
            square([cutout_width, thickness]);
    }
}

module cap() {
    union() {
        square([thickness, thickness*2 + gutter_thickness]);
        translate([thickness, 0, 0])
            square([thickness, thickness]);
    }
}

union () {
    linear_extrude(width) profile();
    difference() {
        translate([0, gutter_inner_height+thickness, 0]) {
            linear_extrude(width + width/2)
                square([thickness*2+gutter_thickness, thickness]);
            translate([thickness, 0, 0])
                linear_extrude(width)
                    square([gutter_thickness, thickness]);
        }

    }
}
