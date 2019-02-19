// Washer
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

/* [Params] */

diameter = 10;
screw_hole_d = 4;
thickness = 5;
resolution = 50;


linear_extrude(thickness)
    difference() {
        circle(d=diameter, center=true, $fn=resolution);
        circle(d=screw_hole_d, center=true, $fn=resolution);
    }
