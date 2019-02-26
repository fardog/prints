// Gutter Downspout "T" Junction
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

use <../lib/utils.scad>;

downspout_w = inch_to_mm(3.2);
downspout_h = inch_to_mm(2.3);
downspout_t = 1.5;
downspout_r = inch_to_mm(0.5);

insert_d = inch_to_mm(3.5);
insert_allowance = 5;
outer_d = inch_to_mm(2.5);
thickness = 3;

screw_d = 4;
screw_offset = inch_to_mm(0.75);

/* [Hidden] */
downspout_vec = [downspout_w, downspout_h];
screw_l = downspout_h + thickness; 
total_height = insert_d + outer_d + downspout_w/2;

module adapt_allowance(vec) {
    hull() {
        translate([insert_allowance/2, insert_allowance/2, 0])
            linear_extrude(1) roundrect(increase(vec, -insert_allowance), downspout_r);
        translate([0, 0, 5]) linear_extrude(1) roundrect(vec, downspout_r);
    }
}

module inner(vec) {
    union() {
        difference() {
            union() {
                linear_extrude(total_height)
                    roundrect(vec, downspout_r);
                translate([downspout_r, 0, insert_d])
                    rotate([0, 45, 0])
                        linear_extrude(downspout_w + outer_d)
                            roundrect(vec, downspout_r);
            }
            linear_extrude(screw_offset*2)
                roundrect(vec, downspout_r);
        }
        linear_extrude(screw_offset*2-insert_allowance)
            translate([insert_allowance/2, insert_allowance/2, 0])
            roundrect(increase(vec, -insert_allowance), downspout_r);
        translate([0, 0, screw_offset*2-insert_allowance])
            adapt_allowance(vec);
    }
}

module screw_through() {
    rotate([-90, 0, 0])
        linear_extrude(screw_l) circle(d=screw_d, center=true);
}

module screws() {
    x = (downspout_w + thickness) / 2;
    translate([x, 0, screw_offset])
        screw_through();
    translate([x, 0, total_height - screw_offset])
        screw_through();
    translate([downspout_r, 0, insert_d])
        rotate([0, 45, 0])
            translate([x, 0, downspout_w + outer_d - screw_offset])
                screw_through();
}

difference() {
    inner(increase(downspout_vec, thickness));
    translate([thickness/2, thickness/2]) inner(downspout_vec);
    screws();
}
