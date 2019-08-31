import solid as s

from . import utils
from . import ParamsBase


class Params(ParamsBase):
    depth: float = 50
    interface_width: float = 36
    screw_radius: float = 2.5
    screw_head_radius: float = 4.5
    screw_head_angle: float = 90
    screw_spacing: float = 5
    corner_radius: float = 3
    cutout_depth: float = 3
    screws_per_side: float = 2


def screws(radius, depth, head_radius, angle, spacing, number):
    screw = utils.screw_hole(radius, depth, head_radius=head_radius, angle=angle)

    return s.union()(
        *[
            s.translate([0, (spacing + head_radius * 2) * i, 0])(screw)
            for i in range(number)
        ]
    )


def main(params: Params):
    depth, interface_width, screw_radius, screw_head_radius, screw_head_angle, screw_spacing, corner_radius, cutout_depth, screws_per_side = list(
        params
    )

    width = screw_head_radius * 4 + screw_spacing * 4 + interface_width
    height = screw_head_radius * 4 + screw_spacing * 3

    screw_y = screw_spacing + screw_head_radius
    screw_x1 = screw_y
    screw_x2 = screw_spacing * 3 + interface_width + screw_head_radius * 3

    cutout = None
    if cutout_depth > 0:
        cutout = s.square([interface_width, cutout_depth])

    profile = utils.roundrect([width, height], corner_radius)
    if cutout is not None:
        cutout_x = screw_spacing * 2 + screw_head_radius * 2
        cutout_y1 = 0
        cutout_y2 = height - cutout_depth

        profile = s.difference()(
            profile,
            s.translate([cutout_x, cutout_y1])(cutout),
            s.translate([cutout_x, cutout_y2])(cutout),
        )

    body = s.linear_extrude(depth)(profile)
    screw_holes = screws(
        screw_radius,
        depth,
        screw_head_radius,
        screw_head_angle,
        screw_spacing,
        screws_per_side,
    )

    return s.difference()(
        body,
        s.translate([screw_x1, screw_y, 0])(screw_holes),
        s.translate([screw_x2, screw_y, 0])(screw_holes),
    )
