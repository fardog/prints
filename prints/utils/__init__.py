import math
import sys
import typing as t

import solid as s


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
