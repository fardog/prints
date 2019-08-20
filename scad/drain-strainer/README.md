# Drain Strainer

A simple customizable strainer for a sink drain.

## Known Dimensions

These dimensions are really only relevant to me; wanted to keep them somewhere
without fiddling with the `.scad` file.

### Basement Wash Tub

#### No Skirt

```
/* [Strainer] */
strainer_type = "square"; // [square: Square,circle: Circle]
strainer_x_mm = 3.0; //[1.0:10.0]
strainer_y_mm = 3.0; //[1.0:10.0]
strainer_thickness_mm = 1.0; //[1.0:3.0]
strainer_grid_spacing_mm = 3.0; //[0.5:3.0]

/* [Drain] */
drain_diameter_mm = 42.5; //[5.0:150.0]
drain_depth_mm = 37.0; //[0.0:50.0]
drain_sleeve_thickness = 1.0; //[1.0:3.0]

/* [Skirt] */
skirt_diameter_mm = 42.5; //[5.0:200.0]
skirt_upper_diameter_mm = 42.5; //[5.0:200.0]
skirt_thickness_mm = 2.0; //[1.0:3.0]
```

#### With Skirt

```
/* [Strainer] */
strainer_type = "square"; // [square: Square,circle: Circle]
strainer_x_mm = 3.0; //[1.0:10.0]
strainer_y_mm = 3.0; //[1.0:10.0]
strainer_thickness_mm = 1.0; //[1.0:3.0]
strainer_grid_spacing_mm = 2.0; //[0.5:3.0]

/* [Drain] */
drain_diameter_mm = 44; //[5.0:150.0]
drain_depth_mm = 10.0; //[0.0:50.0]
drain_sleeve_thickness = 1.0; //[0.5:3.0]

/* [Skirt] */
skirt_diameter_mm = 50; //[5.0:200.0]
skirt_upper_diameter_mm = 48; //[5.0:200.0]
skirt_thickness_mm = 1.0; //[1.0:3.0]
```
