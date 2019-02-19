// Porch Gutter "L" Bracket for Small Improvised Gutter
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

use <../lib/utils.scad>;

gutter_height = 56.5;
beam_width = 20;
beam_attachment_depth = 40;
bracket_thickness = 5;
bracket_chamfer_depth = 5;

beam_screw_d = 5;
gutter_screw_d = 3;
gutter_screw_top_offset = 15;

/* [Hidden] */
chamfer_points = [
    [0, 0],
    [bracket_chamfer_depth, 0],
    [bracket_chamfer_depth, bracket_chamfer_depth]
];


module bracket_profile() {
    union() {
        square([beam_attachment_depth, bracket_thickness]);
        translate([beam_attachment_depth, 0, 0])
            square([bracket_thickness, gutter_height]);
        if (bracket_chamfer_depth > 0) {
            translate([beam_attachment_depth-bracket_chamfer_depth, bracket_thickness, 0])
            polygon(points=chamfer_points);
        }
    }
}

difference() {
    linear_extrude(beam_width)
        bracket_profile();
    translate([beam_attachment_depth/2, bracket_thickness, beam_width/2])
        rotate([90, 0, 0]) screw(d=beam_screw_d, l=bracket_thickness);
    translate([beam_attachment_depth, gutter_height-gutter_screw_top_offset, beam_width/2])
        rotate([0, 90, 0]) screw(d=gutter_screw_d, l=bracket_thickness);
}
