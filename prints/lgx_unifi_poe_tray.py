"""
An LGX casette insert which can hold a Unifi PoE injector.

This is really poorly written; I wouldn't look at this as an example.
"""
from solid.objects import (
    circle,
    debug,
    difference,
    linear_extrude,
    polygon,
    rotate,
    square,
    translate,
    union,
)
from solid.utils import down, forward, right

from . import ParamsBase
from .utils import roundrect

LGX_FACE_WIDTH: float = 130
LGX_FACE_HEIGHT: float = 30
LGX_HOLE_D: float = 5
LGX_PLATFORM_OFFSET: float = 0.5
LGX_PLATFORM_WIDTH: float = 104


class Params(ParamsBase):
    lgx_face_extra_height: float = 3
    lgx_rack_thickness: float = 2.5
    platform_thickness: float = 2
    face_thickness: float = 2
    face_radius: float = 2
    face_post_d: float = 6.2
    face_post_separation: float = 118
    screw_d: float = 3.2  # TODO
    poe_face_width: float = 40
    poe_face_height: float = 25.5
    poe_face_lift: float = 2
    poe_face_radius: float = 3
    poe_width: float = 60.5
    poe_depth: float = 105.6
    poe_retainer_height: float = 5


def main(params: Params):
    # face
    face_profile = roundrect(
        [LGX_FACE_WIDTH, LGX_FACE_HEIGHT + params.lgx_face_extra_height],
        params.face_radius,
    )
    cutout_profile = roundrect(
        [params.poe_face_width, params.poe_face_height], params.poe_face_radius
    )
    cutout_x = LGX_FACE_WIDTH / 2 - params.poe_face_width / 2
    cutout_y = params.poe_face_lift + params.platform_thickness
    cutout = translate([cutout_x, cutout_y, 0])(cutout_profile)
    cutout_extrude = debug(
        down(params.lgx_rack_thickness)(
            linear_extrude(params.face_thickness + params.lgx_rack_thickness)(cutout)
        )
    )

    post = circle(d=params.face_post_d)
    posts = post + right(params.face_post_separation)(post)
    posts = translate(
        [LGX_FACE_WIDTH / 2 - params.face_post_separation / 2, LGX_FACE_HEIGHT / 2, 0]
    )(posts)

    face = difference()(face_profile, posts)
    face_extrusion = linear_extrude(height=params.face_thickness)(face)

    tray_depth = (
        params.platform_thickness + params.poe_depth + params.lgx_rack_thickness
    )

    # tray
    tray = linear_extrude(height=params.platform_thickness)(
        square(size=[LGX_PLATFORM_WIDTH, tray_depth])
    )

    poe_holder_outer_params = [
        params.poe_width + params.platform_thickness * 2,
        tray_depth,
    ]
    poe_holder_profile = difference()(
        square(poe_holder_outer_params),
        right(params.platform_thickness)(
            forward(params.lgx_rack_thickness)(
                square(
                    [
                        params.poe_width,
                        params.poe_depth,
                    ]
                )
            )
        ),
    )
    poe_holder_extrude = linear_extrude(height=params.poe_retainer_height)(
        poe_holder_profile
    )
    poe_holder = translate(
        [
            LGX_PLATFORM_WIDTH / 2 - poe_holder_outer_params[0] / 2,
            0,
            params.platform_thickness,
        ]
    )(poe_holder_extrude)

    tray = union()(poe_holder, tray)
    tray = rotate([270, 0, 0])(
        translate([LGX_FACE_WIDTH / 2 - LGX_PLATFORM_WIDTH / 2, 0, 0])(tray)
    )

    # support
    support_start_inset = (
        params.platform_thickness + LGX_FACE_WIDTH / 2 - LGX_PLATFORM_WIDTH / 2
    )
    point_extent = LGX_FACE_HEIGHT - params.platform_thickness
    support_profile = polygon([[0, 0], [0, point_extent], [point_extent, 0]])
    support = linear_extrude(height=params.platform_thickness)(support_profile)
    support = rotate([270, 0, 90])(support)
    support_left = translate([support_start_inset, 0, 0])(support)
    support_right = translate(
        [support_start_inset + LGX_PLATFORM_WIDTH - params.platform_thickness, 0, 0]
    )(support)

    return difference()(
        union()(face_extrusion, tray, support_left, support_right), cutout_extrude
    )
