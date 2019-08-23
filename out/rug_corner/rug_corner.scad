

difference() {
	linear_extrude(height = 0.8000000000) {
		union() {
			square(size = [56, 150]);
			translate(v = [0, 56, 0]) {
				rotate(a = [0, 0, -90]) {
					square(size = [56, 150]);
				}
			}
		}
	}
	translate(v = [2, 2, 0.6000000000]) {
		linear_extrude(height = 0.2000000000) {
			union() {
				square(size = [52, 146]);
				translate(v = [0, 52, 0]) {
					rotate(a = [0, 0, -90]) {
						square(size = [52, 146]);
					}
				}
			}
		}
	}
}