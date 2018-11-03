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
