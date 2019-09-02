import solid as s

from . import utils


class Params(utils.ProfileWithScrewsParams):
    depth: float = 50
    interface_width: float = 36
    corner_radius: float = 3
    screw_radius: float = 2.5
    screw_head_radius: float = 4.5
    screw_head_angle: float = 90
    screw_spacing: float = 5
    screws_per_side: float = 2
    cutout_depth: float = 3


def main(params: Params):
    profile = utils.profile_with_screws(params)

    cutout = None
    if params.cutout_depth > 0:
        cutout = s.linear_extrude(params.depth)(
            s.square([params.interface_width, params.cutout_depth])
        )

    if cutout is not None:
        cutout_x = params.screw_spacing * 2 + params.screw_head_radius * 2
        cutout_y1 = 0
        cutout_y2 = params.height - params.cutout_depth

        profile = s.difference()(
            profile,
            s.translate([cutout_x, cutout_y1])(cutout),
            s.translate([cutout_x, cutout_y2])(cutout),
        )

    return profile
