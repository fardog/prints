// Drain Strainer
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

/* [Strainer] */
strainer_x_mm = 3.0; //[1.0:10.0]
strainer_y_mm = 3.0; //[1.0:10.0]
strainer_thickness_mm = 2.0; //[1.0:3.0]
strainer_grid_spacing_mm = 1.0; //[0.5:3.0]

/* [Drain] */
drain_diameter_mm = 30.0; //[5.0:150.0]
drain_depth_mm = 10.0; //[0.0:50.0]
drain_sleeve_thickness = 2.0; //[1.0:3.0]

/* [Skirt] */
skirt_diameter_mm = 40.0; //[5.0:200.0]
skirt_upper_diameter_mm = 38.0; //[5.0:200.0]
skirt_thickness_mm = 2.0; //[1.0:3.0]

/* [Hidden] */
skirt_z_offset = drain_depth_mm - skirt_thickness_mm;

module drain_sleeve() {
    difference() {
        cylinder(h=drain_depth_mm, d=drain_diameter_mm);
        cylinder(h=drain_depth_mm, d=drain_diameter_mm-drain_sleeve_thickness);
    }
}

module strainer() {
    union() {
        difference() {
            cylinder(h=strainer_thickness_mm, d=drain_diameter_mm);
            cylinder(h=strainer_thickness_mm, d=drain_diameter_mm-drain_sleeve_thickness);
        }
        difference() {
            cylinder(h=strainer_thickness_mm, d=drain_diameter_mm);

            x_size = strainer_x_mm + strainer_grid_spacing_mm;
            x_total = ceil(drain_diameter_mm / x_size) * x_size;
            x_offset = (x_total - strainer_grid_spacing_mm) / 2;
            y_size = strainer_y_mm + strainer_grid_spacing_mm;
            y_total = ceil(drain_diameter_mm / y_size) * y_size;
            y_offset = (y_total - strainer_grid_spacing_mm) / 2;

            translate([-x_offset, -y_offset, 0]) {
                for (x = [0:x_size:drain_diameter_mm]) {
                    translate([x,0,0])
                    for (y = [0:y_size:drain_diameter_mm]) {
                        translate([0, y, 0])
                            cube([strainer_x_mm, strainer_y_mm, strainer_thickness_mm]);
                    }
                }
            }
        }
    }
}

module skirt() {
    difference() {
        cylinder(h=skirt_thickness_mm, d1=skirt_diameter_mm, d2=skirt_upper_diameter_mm);
        cylinder(h=skirt_thickness_mm, d=drain_diameter_mm);
    }
}

union() {
    drain_sleeve();
    strainer();
    translate([0, 0, skirt_z_offset])
        skirt();
}
