from solid import square, linear_extrude, difference, translate, union, rotate


class Params(object):
    thickness: float = 1
    inset_depth: float = 0.4
    inset_width: float = 52
    frame_width: float = 2
    side_length: float = 150


def profile(width: float, length: float, thickness: float):
    shape = union()(
        square(size=[width, length]),
        translate([0, width, 0])(rotate([0, 0, -90])(square(size=[width, length]))),
    )

    return linear_extrude(height=thickness)(shape)


def main(params: Params):
    outer_width = params.inset_width + params.frame_width * 2

    shape = difference()(
        profile(outer_width, params.side_length, params.thickness),
        translate(
            [
                params.frame_width,
                params.frame_width,
                params.thickness - params.inset_depth,
            ]
        )(
            profile(
                params.inset_width,
                params.side_length - params.frame_width * 2,
                params.inset_depth,
            )
        ),
    )
    return shape
