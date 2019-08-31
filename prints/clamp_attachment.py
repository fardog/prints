import solid as s

from . import utils


class Params(object):
    depth: float = 50
    interface_width: float = 35
    screw_radius: float = 2.5
    screw_head_radius: float = 4.5
    screw_head_angle: float = 90
    screw_spacing: float = 5
    corner_radius: float = 3
    cutout_depth: float = 3


def main(params: Params):
    width = (
        params.screw_head_radius * 4 + params.screw_spacing * 4 + params.interface_width
    )
    height = params.screw_head_radius * 2 + params.screw_spacing * 2

    screw_y = params.screw_spacing + params.screw_head_radius
    screw_x1 = screw_y
    screw_x2 = (
        params.screw_spacing * 3 + params.interface_width + params.screw_head_radius * 3
    )

    cutout = None
    if params.cutout_depth > 0:
        cutout = s.square([params.interface_width, params.cutout_depth])

    profile = utils.roundrect([width, height], params.corner_radius)
    if cutout is not None:
        cutout_x = params.screw_spacing * 2 + params.screw_head_radius * 2
        cutout_y1 = 0
        cutout_y2 = height - params.cutout_depth

        profile = s.difference()(
            profile,
            s.translate([cutout_x, cutout_y1])(cutout),
            s.translate([cutout_x, cutout_y2])(cutout),
        )

    body = s.linear_extrude(params.depth)(profile)
    screw = utils.screw_hole(
        params.screw_radius,
        params.depth,
        head_radius=params.screw_head_radius,
        angle=params.screw_head_angle,
    )
    return s.difference()(
        body,
        s.translate([screw_x1, screw_y, 0])(screw),
        s.translate([screw_x2, screw_y, 0])(screw),
    )
