// Reloop Hinge Adapter for Technics SL-1200mk5
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

use <../lib/utils.scad>;

/* [Interface] */
width = 57;
height = 22;
depth = 8;

/* [Screws] */
screw_distance = 33.3;
screw_top_offset = 10;
screw_d = 3;
screw_head = 5.6;
screw_inset = 3;

/* [Adapter] */
adapter_width = 12;
adapter_height = 19;
adapter_depth = 12.2;
adapter_thickness = 3;
adapter_notch_width = 18;
adapter_notch_depth = 3;
adapter_chamfer = 3;

/* [Hidden] */
adapter_offset = width/2 - adapter_width/2;
adapter_outer_width = adapter_width + adapter_thickness*2;
adapter_outer_height = adapter_height + adapter_thickness;
adapter_outer_offset = width/2 - adapter_outer_width/2;
adapter_outer_depth = adapter_depth + adapter_thickness;
adapter_notch_offset = width/2 - adapter_notch_width/2;

module screw() {
    inset_screw(
        d=screw_d,
        l=depth,
        head_d=screw_head,
        inset=screw_inset
    );
}

function plus_pct(num, pct) = num + (num * pct/100);

module chamfer() {
    union() {
        translate([0, adapter_depth/2, 0])
            linear_extrude(plus_pct(adapter_chamfer, 33), scale=1.3)
                square([adapter_width, adapter_depth], center=true);
        translate([0, adapter_notch_depth/2, 0])
            linear_extrude(plus_pct(adapter_chamfer, 33), scale=[1.3, 2])
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
            screw();
        translate([screw_distance / 2, 0, 0])
            screw();
    }
}

