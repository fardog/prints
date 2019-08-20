// Vinyl Record Display, Wall Mount
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

use <../lib/utils.scad>;

printing = "mount"; // ["tray", "mount"]

/* [Dimensions] */
width = 100;
tray_depth = 10;
tray_retainer_height = 10;
tray_thickness = 5;
tray_back_angle = 82;
tray_back_height = 20;
tray_back_thickness = 15;
tray_bottom_angle = 15;

/* [Mounting Plate] */
screw_d = 5;
screw_head_d = 9;
screw_slop = 4;
screw_plate_end_offset = 15;
screw_inset_extra = 1.5;
plate_thickness = 7;
plate_screw_allowance = 2;
plate_mount_inset = 10;
plate_tab_width = 2;
plate_insert_slop = 0.4;
plate_insert_amount = 5;

/* [Hidden] */
tray_back = [tray_back_thickness, tray_back_height];
tray_back_angle_bottom = tray_back_height / tan(tray_back_angle);
tray_angle = [
    [0, 0],
    [tray_back_angle_bottom, 0],
    [0, tray_back_height]
];
bottom_width = tray_back_thickness + tray_back_angle_bottom + tray_depth + tray_thickness;

tray_bottom_angle_bottom = (tray_depth + tray_back_angle_bottom) * tan(tray_bottom_angle);
tray_bottom_angle_poly = [
    [0, 0],
    [tray_depth, 0],
    [0, tray_bottom_angle_bottom]
];

plate_width = width - plate_mount_inset*2;
plate_height = screw_d + screw_slop*2 + plate_screw_allowance*2;

$fn = 50;

module plate_profile(inc=0) {
    t = [plate_tab_width, (plate_thickness/2)+inc, 0];
    union() {
        square([plate_width+inc, (plate_thickness/2)+inc]);
        translate(t)
            square([(plate_width-plate_tab_width*2)+inc, (plate_thickness/2)+inc]);
    }
}

module screw_profile(d, allowance) {
    translate([0, -allowance/2, 0])
        hull() {
            circle(d=d, center=true);
            translate([0, allowance, 0])
                circle(d=d, center=true);
        }
}

module profile() {
    union() {
        translate([0, tray_thickness, 0])
            square(tray_back);
        translate([tray_back_thickness, tray_thickness, 0])
            polygon(tray_angle);
        translate([tray_back_thickness, tray_thickness, 0])
            polygon(tray_bottom_angle_poly);
        square([bottom_width, tray_thickness]);
        translate([bottom_width-tray_thickness, tray_thickness, 0])
            square([tray_thickness, tray_retainer_height]);
    }
}

module screw_cutout() {
    rotate([-90, 0, 0]) {
        union() {
            linear_extrude(plate_thickness*2)
                screw_profile(screw_d, plate_screw_allowance);
            linear_extrude(plate_thickness/2 + screw_inset_extra)
                screw_profile(screw_head_d, plate_screw_allowance);
        }
    }
}

if (printing == "tray") {
    iam = plate_height + plate_insert_amount;
    difference() {
        linear_extrude(width) profile();
        translate([plate_thickness-plate_insert_slop, iam, plate_mount_inset-plate_insert_slop/2])
            rotate([-90, -90, 180]) linear_extrude(iam)
                plate_profile(inc=plate_insert_slop);
    }
} else if (printing == "mount") {
    difference() {
        linear_extrude(plate_height) plate_profile();
        translate([screw_plate_end_offset, -1, plate_height/2])
            screw_cutout();
        translate([plate_width - screw_plate_end_offset, -1, plate_height/2])
            screw_cutout();
    }
}
