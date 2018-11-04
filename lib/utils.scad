module cone(r, angle, invert=false) {
    h = tan(angle / 2) * r;
    translate([0, 0, -h]) {
        if (invert) {
                cylinder(r1=r,r2=0,h=h, $fn=20); 
        } else {
            cylinder(r1=0,r2=r,h=h, $fn=20); 
        }
    }
}

module roundrect(vect, r, $fn=20) {
    sq = len(vect) > 1 ? [for (i = [0:1:len(vect)-1]) vect[i] - r * 2] : vect - r * 2;
    minkowski() {
        square(sq);
        translate([r, r])
            circle(r=r);
    }
}
