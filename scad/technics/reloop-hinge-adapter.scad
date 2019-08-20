// Reloop Hinge Adapter for Technics SL-1200mk5
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

use <../lib/utils.scad>;

/* [Interface] */
// width of turntable attachment
width = 57;
// height of turntable attachment
height = 22;
// depth of part; should be enough for the screw head inset to remain strong
depth = 8;

/* [Screws] */
// distance between screw hole centers
screw_distance = 33.3;
// distance the screw hole center should be from the top of the interface
screw_top_offset = 10;
// diameter of screw hole
screw_d = 3;
// diameter of screw head
screw_head = 5.6;
// screw head inset
screw_inset = 3;
// screw head angle, in degrees. typical values are 82, 90.
screw_angle = 0;

/* [Adapter] */
// width of adapter; where the hinge post inserts
adapter_width = 12;
// height of adapter; how far the hinge post inserts into the adapter
adapter_height = 19;
// depth of adapter; how much distance between the back of the turntable, and the adapter
adapter_depth = 12.2;
// thickness of adapter walls
adapter_thickness = 3;
// width of the adapter notch; should be greater than the adapter width
adapter_notch_width = 18;
// deptth of adapter notch
adapter_notch_depth = 3;
// chamfer of adapter, to make insertion of the adapter easier
adapter_chamfer = 3.0; // [2.5:3.5]

/* [Hidden] */
adapter_offset = width/2 - adapter_width/2;
adapter_outer_width = adapter_width + adapter_thickness*2;
adapter_outer_height = adapter_height + adapter_thickness;
adapter_outer_offset = width/2 - adapter_outer_width/2;
adapter_outer_depth = adapter_depth + adapter_thickness;
adapter_notch_offset = width/2 - adapter_notch_width/2;
adapter_chamfer_magic1 = adapter_chamfer * 0.433;
adapter_chamfer_magic2 = adapter_chamfer * 0.666;

module interface_screw() {
    inset_screw(
        d=screw_d,
        l=depth,
        head_d=screw_head,
        inset=screw_inset,
        angle=screw_angle
    );
}

function plus_pct(num, pct) = num + (num * pct/100);

module chamfer() {
    union() {
        translate([0, adapter_depth/2, 0])
            linear_extrude(plus_pct(adapter_chamfer, 33), scale=adapter_chamfer_magic1)
                square([adapter_width, adapter_depth], center=true);
        translate([0, adapter_notch_depth/2, 0])
            linear_extrude(plus_pct(adapter_chamfer, 33), scale=[adapter_chamfer_magic1, adapter_chamfer_magic2])
                square([adapter_notch_width, adapter_notch_depth], center=true);
    }
}

difference() {
    // interface + adapter outer
    union () {
        linear_extrude(depth)
            square([width, height]);
        translate([adapter_outer_offset, 0, 0])
            linear_extrude(adapter_outer_depth)
                square([adapter_outer_width, adapter_outer_height]);
    }

    // adapter
    translate([adapter_offset, 0, 0])
        linear_extrude(adapter_depth)
            square([adapter_width, adapter_height]);
    // adapter notch
    translate([adapter_notch_offset, 0, 0])
        linear_extrude(adapter_notch_depth)
            square([adapter_notch_width, adapter_height]);

    if (adapter_chamfer > 0) {
        translate([width/2, adapter_chamfer, 0])
            rotate([90, 0, 0])
                chamfer();
    }

    // screws
    translate([width / 2, screw_top_offset, 0]) {
        translate([-screw_distance / 2, 0, 0])
            interface_screw();
        translate([screw_distance / 2, 0, 0])
            interface_screw();
    }
}

