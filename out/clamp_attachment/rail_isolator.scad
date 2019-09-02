$fn = 20;


difference() {
	difference() {
		linear_extrude(height = 10) {
			minkowski() {
				square(size = [30.0000000000, 17.0000000000]);
				translate(v = [3, 3, 0]) {
					circle(r = 3);
				}
			}
		}
		translate(v = [6.5000000000, 6.5000000000, 0]) {
			union() {
				translate(v = [0, 0.0000000000, 0]) {
					union() {
						linear_extrude(height = 10) {
							circle(r = 1.7500000000);
						}
						translate(v = [0, 0, 10]) {
							translate(v = [0, 0, -5.6692131669]) {
								cylinder(h = 5.6692131669, r1 = 0, r2 = 3.5000000000);
							}
						}
					}
				}
				translate(v = [0, 10.0000000000, 0]) {
					union() {
						linear_extrude(height = 10) {
							circle(r = 1.7500000000);
						}
						translate(v = [0, 0, 10]) {
							translate(v = [0, 0, -5.6692131669]) {
								cylinder(h = 5.6692131669, r1 = 0, r2 = 3.5000000000);
							}
						}
					}
				}
			}
		}
		translate(v = [29.5000000000, 6.5000000000, 0]) {
			union() {
				translate(v = [0, 0.0000000000, 0]) {
					union() {
						linear_extrude(height = 10) {
							circle(r = 1.7500000000);
						}
						translate(v = [0, 0, 10]) {
							translate(v = [0, 0, -5.6692131669]) {
								cylinder(h = 5.6692131669, r1 = 0, r2 = 3.5000000000);
							}
						}
					}
				}
				translate(v = [0, 10.0000000000, 0]) {
					union() {
						linear_extrude(height = 10) {
							circle(r = 1.7500000000);
						}
						translate(v = [0, 0, 10]) {
							translate(v = [0, 0, -5.6692131669]) {
								cylinder(h = 5.6692131669, r1 = 0, r2 = 3.5000000000);
							}
						}
					}
				}
			}
		}
	}
	translate(v = [13.0000000000, 0, 5]) {
		linear_extrude(height = 5) {
			square(size = [10, 23.0000000000]);
		}
	}
}