$fn = 20;


difference() {
	difference() {
		linear_extrude(height = 50) {
			minkowski() {
				square(size = [68.0000000000, 27.0000000000]);
				translate(v = [3, 3, 0]) {
					circle(r = 3);
				}
			}
		}
		translate(v = [9.5000000000, 9.5000000000, 0]) {
			union() {
				translate(v = [0, 0.0000000000, 0]) {
					union() {
						linear_extrude(height = 50) {
							circle(r = 2.5000000000);
						}
						translate(v = [0, 0, 50]) {
							translate(v = [0, 0, -7.2889883574]) {
								cylinder(h = 7.2889883574, r1 = 0, r2 = 4.5000000000);
							}
						}
					}
				}
				translate(v = [0, 14.0000000000, 0]) {
					union() {
						linear_extrude(height = 50) {
							circle(r = 2.5000000000);
						}
						translate(v = [0, 0, 50]) {
							translate(v = [0, 0, -7.2889883574]) {
								cylinder(h = 7.2889883574, r1 = 0, r2 = 4.5000000000);
							}
						}
					}
				}
			}
		}
		translate(v = [64.5000000000, 9.5000000000, 0]) {
			union() {
				translate(v = [0, 0.0000000000, 0]) {
					union() {
						linear_extrude(height = 50) {
							circle(r = 2.5000000000);
						}
						translate(v = [0, 0, 50]) {
							translate(v = [0, 0, -7.2889883574]) {
								cylinder(h = 7.2889883574, r1 = 0, r2 = 4.5000000000);
							}
						}
					}
				}
				translate(v = [0, 14.0000000000, 0]) {
					union() {
						linear_extrude(height = 50) {
							circle(r = 2.5000000000);
						}
						translate(v = [0, 0, 50]) {
							translate(v = [0, 0, -7.2889883574]) {
								cylinder(h = 7.2889883574, r1 = 0, r2 = 4.5000000000);
							}
						}
					}
				}
			}
		}
	}
	translate(v = [19.0000000000, 0]) {
		linear_extrude(height = 50) {
			square(size = [36, 3]);
		}
	}
	translate(v = [19.0000000000, 30.0000000000]) {
		linear_extrude(height = 50) {
			square(size = [36, 3]);
		}
	}
}