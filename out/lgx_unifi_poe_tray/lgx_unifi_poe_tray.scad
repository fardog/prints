$fn = 20;


difference() {
	union() {
		linear_extrude(height = 2) {
			difference() {
				minkowski() {
					square(size = [126, 29]);
					translate(v = [2, 2, 0]) {
						circle(r = 2);
					}
				}
				translate(v = [6.0000000000, 15.0000000000, 0]) {
					union() {
						circle(d = 6.2000000000);
						translate(v = [118, 0, 0]) {
							circle(d = 6.2000000000);
						}
					}
				}
			}
		}
		rotate(a = [270, 0, 0]) {
			translate(v = [13.0000000000, 0, 0]) {
				union() {
					translate(v = [19.7500000000, 0, 2]) {
						linear_extrude(height = 5) {
							difference() {
								square(size = [64.5000000000, 110.1000000000]);
								translate(v = [2, 0, 0]) {
									translate(v = [0, 2.5000000000, 0]) {
										square(size = [60.5000000000, 105.6000000000]);
									}
								}
							}
						}
					}
					linear_extrude(height = 2) {
						square(size = [104, 110.1000000000]);
					}
				}
			}
		}
		translate(v = [15.0000000000, 0, 0]) {
			rotate(a = [270, 0, 90]) {
				linear_extrude(height = 2) {
					polygon(paths = [[0, 1, 2]], points = [[0, 0], [0, 28], [28, 0]]);
				}
			}
		}
		translate(v = [117.0000000000, 0, 0]) {
			rotate(a = [270, 0, 90]) {
				linear_extrude(height = 2) {
					polygon(paths = [[0, 1, 2]], points = [[0, 0], [0, 28], [28, 0]]);
				}
			}
		}
	}
	#translate(v = [0, 0, -2.5000000000]) {
		linear_extrude(height = 4.5000000000) {
			translate(v = [45.0000000000, 4, 0]) {
				minkowski() {
					square(size = [34, 19.5000000000]);
					translate(v = [3, 3, 0]) {
						circle(r = 3);
					}
				}
			}
		}
	}
}