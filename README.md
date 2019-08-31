# prints

Various [OpenSCAD][] models, STLs and gcode generated from those models. They
are either in raw SCAD, or [SolidPython][].

* SCAD files can be found in [`./scad`](./scad)
* SolidPython can be found in [`./prints`](./prints)

gcode is generated for a [Prusa i3 MK3][i3mk3], from my [slic3r-presets][];
settings are written into the gcode, so inspect the end of the files to see what
settings they use.

## Generating SCAD

There is a hacked together script for generating scad files; to use:

1. Install Python 3.6+
1. Install requirements from `requirements.txt`
1. Create a new module in the `prints` directory, following the module format
   described below.
1. Run `./scripts/solid module_name -- --param_override=value`

### Module Format

A module must export the following:

1. A `Params` class, which includes Python 3 type annotations for each parameter
   and inherits `prints.ParamsBase`
1. A `main(params: Params)` function, which takes an instantiated `Prams` class
   and returns a `solidpython` object

Until this is better documented, see the [clamp
attachment](./prints/clamp_attachment.py) module.

## License

[Creative Commons Attribution (CC BY
3.0)](https://creativecommons.org/licenses/by/3.0/)

Some models are released under different licenses, depending on their original
source (if any). For those purposes, a `LICENSE` file in a given folder, or a
license header in a particular file takes precedence over the repos overall
license.

[OpenSCAD]: https://www.openscad.org/
[SolidPython]: https://github.com/SolidCode/SolidPython
[i3mk3]: https://www.prusa3d.com/original-prusa-i3-mk3/
[slic3r-presets]: https://github.com/fardog/slic3r-presets/
