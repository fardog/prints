// Isolation Pad
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

use <../lib/utils.scad>;

/* [Dimensions] */
foot_distance_x = 74;
foot_distance_y = 74;
foot_diameter = 15;
foot_depth = 2;

pad_x = inch_to_mm(5);
pad_y = inch_to_mm(5);
pad_thickness = 5;
pad_overhang_xy = 5;
pad_overhang_z = 3;


/* [Hidden] */
pad_total_x = pad_x + pad_overhang_xy*2;
pad_total_y = pad_y + pad_overhang_xy*2;
pad_total_thickness = pad_thickness + pad_overhang_z;
foot_offset = [foot_distance_x/2, foot_distance_y/2, -foot_depth];

module pad_profile() {
    square([pad_total_x, pad_total_y], center=true);
}

module pad_inset_profile() {
    square([pad_x, pad_y], center=true);
}

module foot_inset() {
    linear_extrude(foot_depth) circle(d=foot_diameter, center=true);
}

module feet() {
    translate(foot_offset) foot_inset();
    mirror([1, 0, 0]) translate(foot_offset) foot_inset();
    rotate([0, 0, 180]) translate(foot_offset) foot_inset();
    mirror([1, 0, 0]) rotate([0, 0, 180]) translate(foot_offset) foot_inset();
}

module pad() {
    difference() {
        linear_extrude(pad_total_thickness) pad_profile();
        linear_extrude(pad_overhang_z) pad_inset_profile();
    }
}

difference() {
    pad();
    #translate([0, 0, pad_total_thickness]) feet();
}
