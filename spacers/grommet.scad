// Grommet
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

/* [Part] */
part = "outer"; // ["outer", "inner", "both"]

/* [Dimensions] */
opening_diameter_mm = 15;
cap_outer_diameter_mm = 25;
cap_inner_diameter_mm = 20;
cap_interface_thickness_mm = 2;
cap_taper_height_mm = 1;

wall_thickness_mm = 2;
passthrough_thickness_mm = 2;
passthrough_distance_mm = 1;

clip_mm = 1;

/* [Tolerances] */
cylinder_tolerance_mm = 0.2;
clip_tolerance_mm = 0.2;

/* [Hidden] */
cap_total_height = cap_interface_thickness_mm + passthrough_distance_mm;
clip_o_mm = clip_mm + clip_tolerance_mm;

$fn=100;

module cap() {
    union() {
        cylinder(
            h=cap_interface_thickness_mm,
            d=cap_outer_diameter_mm
        );
    }
}

module outer() {
    clip_x = opening_diameter_mm+wall_thickness_mm;
    difference() {
        union() {
            translate([0, 0, passthrough_distance_mm]) cap();
            cylinder(
                h=passthrough_distance_mm,
                d=opening_diameter_mm+wall_thickness_mm*2
            );
        }
        cylinder(
            h=cap_total_height,
            d=opening_diameter_mm+cylinder_tolerance_mm+wall_thickness_mm
        );
        rotate([0, 0, -36])
            rotate_extrude(angle=72, convexity=100)
                translate([clip_x/2, cap_total_height-clip_o_mm, 0])
                    square([clip_o_mm, clip_o_mm]);
        rotate([0, 0, 144])
            rotate_extrude(angle=72, convexity=100)
                translate([clip_x/2, cap_total_height-clip_o_mm, 0])
                    square([clip_o_mm, clip_o_mm]);

        rotate([0, 0, -36])
            rotate_extrude(angle=72, convexity=100)
                translate([clip_x/2, 0, 0])
                    square([clip_o_mm/2, cap_total_height]);
        rotate([0, 0, 144])
            rotate_extrude(angle=72, convexity=100)
                translate([clip_x/2, 0, 0])
                    square([clip_o_mm/2, cap_total_height]);

    }
}

module inner() {
    clip_x = opening_diameter_mm+wall_thickness_mm;
    difference() {
        union() {
            translate([0, 0, cap_total_height]) cap();
            cylinder(
                h=cap_total_height,
                d=opening_diameter_mm+wall_thickness_mm
            );
            rotate([0, 0, -35])
                rotate_extrude(angle=70, convexity=100)
                    translate([clip_x/2, clip_mm, 0])
                        polygon(points=[[0, 0], [clip_mm, 0], [0, -clip_mm]]);
            rotate([0, 0, 145])
                rotate_extrude(angle=70, convexity=100)
                    translate([clip_x/2, clip_mm, 0])
                        polygon(points=[[0, 0], [clip_mm, 0], [0, -clip_mm]]);
        }
        cylinder(
            h=passthrough_distance_mm+cap_total_height*2,
            d=opening_diameter_mm
        );
    }
}

if (part == "outer") {
    outer();
} else if (part == "inner") {
    inner();
} else {
    outer();
    translate([0, 0, cap_total_height])
        rotate([0, 180, 0]) inner();
}
