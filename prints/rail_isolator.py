import solid as s

from . import utils


class Params(utils.ProfileWithScrewsParams):
    depth: float = 10
    interface_width: float = 10
    corner_radius: float = 3
    screw_radius: float = 1.75
    screw_head_radius: float = 3.5
    screw_head_angle: float = 90
    screw_spacing: float = 3
    screws_per_side: float = 2
    cutout_depth: float = 5


def main(params: Params):
    profile = utils.profile_with_screws(params)

    cutout = None
    if params.cutout_depth > 0:
        cutout = s.linear_extrude(params.cutout_depth)(
            s.square([params.interface_width, params.height])
        )

    if cutout is not None:
        cutout_x = params.screw_spacing * 2 + params.screw_head_radius * 2
        cutout_z = params.depth - params.cutout_depth
        profile = s.difference()(profile, s.translate([cutout_x, 0, cutout_z])(cutout))

    return profile
