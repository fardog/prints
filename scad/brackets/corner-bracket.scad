// Corner Bracket
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

use <../lib/utils.scad>;

/* [Object] */
object_depth_mm = 9.5;
object_front_overlap_mm = 3;
object_rear_overlap_mm = 12;

/* [Screw] */
screw_d_mm = 4;
screw_inset_head = true;
screw_additional_inset = 4;
screw_head_angle = 82;
screw_head_mm = 7;

/* [Bracket] */
thickness_mm = 3;
screw_offset_r_mm = 1;

/* [Hidden] */
total_depth = object_depth_mm + thickness_mm * 2;
total_side = screw_head_mm + screw_offset_r_mm * 2 + object_rear_overlap_mm;
object_offset = total_side - object_rear_overlap_mm;
front_offset = object_offset + object_front_overlap_mm;
front_size = total_side - front_offset;
screw_center = screw_head_mm / 2 + screw_offset_r_mm;
screw_top = total_depth - screw_additional_inset;

difference() {
    // body
    linear_extrude(total_depth)
        square(total_side);
    // object cutout
    translate([object_offset, object_offset, thickness_mm])
        union() {
            // main cutout
            linear_extrude(object_depth_mm)
                square(object_rear_overlap_mm);
            // front cutout
            translate([object_front_overlap_mm, object_front_overlap_mm, object_depth_mm])
                linear_extrude(thickness_mm)
                    square(object_rear_overlap_mm - object_front_overlap_mm);
        }
    // screw hole
    translate([screw_center, screw_center, 0])
        inset_screw(
            d=screw_d_mm,
            l=total_depth,
            head_d=screw_head_mm,
            angle=screw_head_angle,
            inset=screw_additional_inset
        );
}
