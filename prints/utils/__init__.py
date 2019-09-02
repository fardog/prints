import math
import sys
import typing as t

import solid as s

from .. import ParamsBase


Vector2 = t.Tuple[float, float]
Vector3 = t.Tuple[float, float, float]


def cone(radius: float, angle: float, invert: t.Optional[bool] = False):
    h = math.tan((180 - angle) / 2) * radius
    r1 = radius if invert else 0
    r2 = 0 if invert else radius

    return s.translate([0, 0, -h])(s.cylinder(r1=r1, r2=r2, h=h))


def screw_hole(
    radius: float,
    length: float,
    head_radius: t.Optional[float] = None,
    cap_depth: t.Optional[float] = None,
    angle=None,
):
    solids = [s.linear_extrude(length)(s.circle(r=radius))]
    if angle is not None:
        counter = s.translate([0, 0, length])(cone(head_radius, angle, False))
        solids.append(counter)
    if cap_depth is not None:
        cut = s.translate([0, 0, length - cap_depth])(
            s.linear_extrude(cap_depth)(s.circle(r=head_radius))
        )
        solids.append(cut)

    return s.union()(*solids)


def inset_screw_hole(
    radius: float,
    length: float,
    head_radius: t.Optional[float] = None,
    inset_depth: t.Optional[float] = None,
    angle=None,
):
    screw_height = length - inset_depth

    return s.union()(
        screw_hole(radius, length, head_radius, angle=angle),
        s.translate([0, 0, screw_height])(
            s.linear_extrude(inset_depth)(s.circle(r=head_radius))
        ),
    )


def roundrect(vector: Vector2, radius: float):
    mod_vec = [v - radius * 2 for v in vector]
    return s.minkowski()(
        s.square(mod_vec), s.translate([radius, radius, 0])(s.circle(r=radius))
    )


def log(out: t.Any):
    if not isinstance(out, str):
        out = str(out)
    sys.stderr.write(out + "\n")


def screws_with_padding(radius, depth, head_radius, angle, spacing, number):
    screw = screw_hole(radius, depth, head_radius=head_radius, angle=angle)

    return s.union()(
        *[
            s.translate([0, (spacing + head_radius * 2) * i, 0])(screw)
            for i in range(number)
        ]
    )


class ProfileWithScrewsParams(ParamsBase):
    depth: float = 50
    interface_width: float = 36
    corner_radius: float = 3
    screw_radius: float = 2.5
    screw_head_radius: float = 4.5
    screw_head_angle: float = 90
    screw_spacing: float = 5
    screws_per_side: float = 2

    @property
    def height(self) -> float:
        num = self.screws_per_side * 2
        return self.screw_head_radius * num + self.screw_spacing * (num - 1)

    @property
    def width(self) -> float:
        return (
            self.screw_head_radius * 4 + self.screw_spacing * 4 + self.interface_width
        )


def profile_with_screws(p: ProfileWithScrewsParams):
    screw_y = p.screw_spacing + p.screw_head_radius
    screw_x1 = screw_y
    screw_x2 = p.screw_spacing * 3 + p.interface_width + p.screw_head_radius * 3

    profile = roundrect([p.width, p.height], p.corner_radius)

    body = s.linear_extrude(p.depth)(profile)
    screw_holes = screws_with_padding(
        p.screw_radius,
        p.depth,
        p.screw_head_radius,
        p.screw_head_angle,
        p.screw_spacing,
        p.screws_per_side,
    )

    return s.difference()(
        body,
        s.translate([screw_x1, screw_y, 0])(screw_holes),
        s.translate([screw_x2, screw_y, 0])(screw_holes),
    )
