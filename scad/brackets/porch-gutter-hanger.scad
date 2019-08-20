// Porch Gutter Hanger for Small Improvised Gutter
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

use <../lib/utils.scad>;

gutter_width = 25;
gutter_inner_height = 25;
gutter_thickness = 1;

roof_inner_offset = 2;
roof_thickness = 2;
roof_to_back = 10;

hanger_thickness = 10;
hanger_gutter_inset = 5;
hanger_outer = 3;
hanger_screw_interface_thickness = 5;

// diameter of screw hole
screw_d = 3;
// diameter of screw head
screw_head = 5.6;
// screw head inset
screw_inset = 3;
// screw head angle, in degrees. typical values are 82, 90.
screw_angle = 0;
screw_len = 14;
screw_nut_depth = 3;
screw_nut_width = 5.6;
screw_backing_width = 10;

/* [Hidden] */
total_width = gutter_width + 2*hanger_outer;
total_height = 
    gutter_inner_height +
    hanger_outer +
    roof_inner_offset;

module top() {
    translate([0, -total_height/2, 0])
        children();
}

module square_center_x(vec) {
    translate([0, -vec[1]/2, 0])
        square(vec, center=true);
}

difference () {
    union() {
        linear_extrude(hanger_thickness)
            square([total_width, total_height], center=true);
        translate([(total_width-hanger_outer)/2, 0, hanger_thickness])
            linear_extrude(screw_nut_width/2)
                square([hanger_outer, screw_backing_width], center=true);
    }

    top() {
        translate([0, gutter_inner_height+hanger_outer, hanger_thickness-hanger_gutter_inset])
            linear_extrude(hanger_gutter_inset)
                square_center_x([gutter_width, gutter_inner_height]);
    }
    top() {
        translate([-(gutter_width/2), hanger_outer, hanger_thickness-hanger_gutter_inset])
            linear_extrude(hanger_gutter_inset)
                square([gutter_thickness, total_height]);
    }

    translate([0, total_height/2, hanger_thickness/2])
        rotate([90, 0, 0])
            screw(d=screw_d, l=screw_len);

    translate([0, total_height/2, hanger_thickness/2])
        translate([0, -roof_inner_offset, 0])
            rotate([90, 0, 0])
                linear_extrude(screw_nut_depth)
                    square([screw_nut_width, screw_nut_width], center=true);

    #translate([total_width/2, 0, hanger_thickness])
        rotate([0, 270, 0])
            screw(d=screw_d, l=screw_len);
}
