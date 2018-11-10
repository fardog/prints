module cone(r, angle, invert=false) {
    h = tan((180 - angle) / 2) * r;
    translate([0, 0, -h]) {
        if (invert) {
                cylinder(r1=r,r2=0,h=h, $fn=20); 
        } else {
            cylinder(r1=0,r2=r,h=h, $fn=20); 
        }
    }
}

module roundrect(vect, r, $fn=20) {
    sq = len(vect) > 1
        ? [for (i = [0:1:len(vect)-1]) vect[i] - r * 2]
        : vect - r * 2;
    minkowski() {
        square(sq);
        translate([r, r])
            circle(r=r);
    }
}

module screw(r, d, l, head, head_d, cap, angle, $fn=20) {
    radius = r > 0 ? r : d / 2;
    head_r = head > 0 ? head : head_d / 2;

    union() {
        if (angle) {
            translate([0, 0, l])
                cone(head_r, angle, false);
        }
        linear_extrude(l)
            circle(r=radius);
        if (cap > 0) {
            translate([0, 0, l - cap])
                linear_extrude(cap)
                    circle(r=head_r);
        }
    }
}

module inset_screw(r, d, l, head, head_d, cap, angle, inset, $fn=20) {
    screw_height = l - inset;
    head_r = head > 0 ? head : head_d / 2;

    union() {
        screw(
            r=r,
            d=d,
            l=screw_height,
            head=head_r,
            cap=cap,
            angle=angle,
            $fn=$fn
        );
        translate([0, 0, screw_height])
            linear_extrude(inset)
                circle(r=head_r);
    }
}

function inch_to_mm(inches) = inches * 25.4;
