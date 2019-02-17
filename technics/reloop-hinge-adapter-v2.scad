// Reloop Hinge Adapter for Technics SL-1200mk5
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

use <../lib/utils.scad>;

/* [Interface] */
// width of turntable attachment
width = 57;
// height of section which contacts the turntable hinge interface
interface_height = 22;
// offset of hinge interface from the surface of the turntable
interface_top_offset = 6.5;
// depth of interface part; this will be made wider by the adapter_interface_offset, but is the base size
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


// how far offset from the hinge interface the adapter insert is
adapter_interface_offset = 1.5;
// width of the hinge insert
adapter_width = 12.4;
// depth of the hinge insert
adapter_depth = 12.4;
// total width of the hinge insert notch, which is larger than the hinge itself
adapter_notch_width = 18.4;
// depth of the notch; this is independent of the adapter_depth, and does not add to it
adapter_notch_depth = 3.4;
// how far the hinge post inserts into the adapter
adapter_insert_depth = 20.5;
// how far from the turntable surface the hinge full insert must be
adapter_top_offset = 14;
// thickness of adapter walls
adapter_thickness = 3;

/* [Hidden] */
total_depth = depth + adapter_interface_offset;
adapter_start = adapter_top_offset - interface_top_offset;
adapter_total_width = adapter_width + adapter_thickness;
adapter_total_depth = adapter_depth + adapter_thickness;
adapter_total_insert = adapter_insert_depth + adapter_thickness;
adapter_n_total_width = adapter_notch_width + adapter_thickness;
adapter_n_total_depth = adapter_notch_depth + adapter_thickness;

module interface_screw() {
    inset_screw(
        d=screw_d,
        l=total_depth,
        head_d=screw_head,
        inset=screw_inset,
        angle=screw_angle
    );
}

module top() {
    translate([0, -interface_height/2, 0])
        children();
}

module adapter_outer() {
    // center y, but not x
    translate([0, adapter_total_insert/2], 0)
        union() {
            linear_extrude(adapter_total_depth)
                square([adapter_total_width, adapter_total_insert], center=true);
            linear_extrude(adapter_n_total_depth)
                square([adapter_n_total_width, adapter_total_insert], center=true);
        }
}

module adapter_inner() {
    // center y, but not x
    translate([0, adapter_insert_depth/2], 0)
        union() {
            linear_extrude(adapter_depth)
                square([adapter_width, adapter_insert_depth], center=true);
            linear_extrude(adapter_notch_depth)
                square([adapter_notch_width, adapter_insert_depth], center=true);
        }
}


difference() {
    union() {
        linear_extrude(total_depth)
            square([width, interface_height], center=true);
        top() {
            translate([0, adapter_start, adapter_interface_offset])
                adapter_outer();
        }
    }

    // adapter cutout
    top() {
        translate([0, adapter_start, adapter_interface_offset])
            adapter_inner();
    }

    // hinge cutout
    top() {
        translate([0, adapter_start/2, adapter_interface_offset])
            linear_extrude(depth)
                square([adapter_notch_width, adapter_start], center=true);
    }

    top() {
        // screws
        translate([0, screw_top_offset, 0]) {
            // left screw
            translate([screw_distance/2, 0, 0])
                interface_screw();
            // right screw
            translate([-screw_distance/2, 0, 0])
                interface_screw();
        }
    }
}
