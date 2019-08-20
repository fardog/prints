// Cassette Frame
// by Nathan Wittstock <nate@fardog.io>

// preview[view: south east, tilt: top diagonal]

/* [Component] */
component = "frame"; //["tongue", "frame"]
is_end = true;

/* [Cassette] */
number_of_cassettes = 7; //[5:15]
x_tolerance_mm = 1.5; //[1.0:3.0]
y_tolerance_mm = 1.0; //[1.0:3.0]

/* [Tower] */
// spacing between cassette cutouts
cassette_spacing_mm = 2; //[1:5]
// depth of cassette inserts
depth_mm = 35; //[10:50]
// width of the cassette cutouts
width_mm = 20; //[10:50]
// width of frame
frame_width_mm = 3; //[2:10]
// minimum depth of frame backing; the total will be this plus the tongue width
frame_depth_min_mm = 4; //[1:3]
// thickness of the tongue that will attach halves, or the feet
tongue_thickness_mm = 5; //[1:3]
// length of the tongue that will attach halves, or have feet on the end
tongue_length_mm = 60;
tongue_width_mm = 15;
tongue_inset_mm = 1;
// distance from the edge of the tongue that the screw cutout should be
tongue_screw_edge_mm = 3;
tongue_screw_nut_d_mm = 5.6;
tongue_screw_head_d_mm = 5.6;
tongue_screw_head_depth_mm = 3;
tongue_screw_d_mm = 3;
tongue_tolerance_mm = 0.3;
tongue_foot_height_mm = 10;
tongue_foot_thickness_mm = 5;

/* [Cassette Cases] */
case_width_mm = 109.0;
case_height_mm = 17.0;
case_depth_mm = 70.0;

/* [Hidden] */
case_total_height = case_height_mm + y_tolerance_mm + cassette_spacing_mm/2;
shift = case_total_height / 2;
total_height = (case_total_height * number_of_cassettes) - (is_end ? shift : case_total_height);
total_width = width_mm + frame_width_mm;
frame_depth = tongue_inset_mm + frame_depth_min_mm;
total_depth = depth_mm + frame_depth;

$fn=50;

echo(total_height);

module frame_solid() {
    cube([total_width, total_height, total_depth]);
}

module cassettes() {
    for (i = [0:number_of_cassettes -1]) {
        current_y = case_total_height * i;
        translate([0, current_y, 0])
            cube([case_width_mm, case_height_mm, case_depth_mm]);
    }
}

module screw_inset() {
    translate([0, 0, frame_depth]) rotate([0, 180, 0]) union() {
        linear_extrude(frame_depth) circle(d=tongue_screw_d_mm);
        linear_extrude(tongue_screw_head_depth_mm) circle(d=tongue_screw_head_d_mm);
    }
}

module frame() {
    difference() {
        frame_solid();
        translate([frame_width_mm, -shift, frame_depth])
            cassettes();
        // tongue cutouts
        translate([frame_width_mm, -shift, 0])
            linear_extrude(tongue_inset_mm) tongue_profile(tongue_tolerance_mm);
        translate([frame_width_mm, total_height-tongue_length_mm+shift, 0])
            linear_extrude(tongue_inset_mm) tongue_profile(tongue_tolerance_mm);
        // screw insets
        translate([frame_width_mm+tongue_width_mm/2, case_total_height])
            screw_inset();
        translate([frame_width_mm+tongue_width_mm/2, case_total_height*(number_of_cassettes-1)])
            screw_inset();
    }
}

module cutout_profile(vec) {
    d = vec[0];
    l = vec[1];
    union() {
        translate([0, d/2, 0])
            circle(d=d);
        translate([0, l-d/2, 0])
            circle(d=d);
        translate([-d/2, d/2, 0])
            square([d, l-d]);
    }
}

module cutout() {
    union() {
        translate([0, tongue_screw_edge_mm, 0])
        linear_extrude(tongue_screw_head_depth_mm)
            cutout_profile([tongue_screw_nut_d_mm, tongue_length_mm - tongue_screw_edge_mm*2]);
        translate([0, tongue_screw_edge_mm, 0])
        linear_extrude(tongue_thickness_mm)
            cutout_profile([tongue_screw_d_mm, tongue_length_mm - tongue_screw_edge_mm*2]);
    }
}

module tongue_profile(tol_mm=0) {
    square([tongue_width_mm+tol_mm, tongue_length_mm]);
}

module tongue() {
    difference() {
        linear_extrude(tongue_thickness_mm) tongue_profile();
        translate([tongue_width_mm/2, 0, 0]) cutout();
    }
}

if (component == "frame") {
    frame();
} else if (component == "tongue") {
    union() {
        tongue();
        if (is_end) {
            translate([0, tongue_length_mm, 0])
                linear_extrude(tongue_foot_height_mm)
                    square([tongue_width_mm, tongue_foot_thickness_mm]);
        }
    }
} else {
    assert(false, "incorrect component setting");
}
