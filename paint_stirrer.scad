// 2024-09-08 adam mead
//
// Paint Stirrer, 3d printable
//

// Variables

// Shaft diameter, larger diameter will allow for more sweep angle on the blades
cShaftDia = 8; 
// Shaft length, including the blades
cShaftLen = 100; 
// Blade diameter, each. 2x blade dia will be the overall width of the paddle
cBladeDia = 20; 
// Blade thickness
cBladeThick = 5; 
// Blade length
cBladeLen = 50; 
// Blade hole diameter
cBladeHoleDia = 14; 
// Refinement level (for the renderer)
cRefine = 32; 
// Refinement level for the blade hole (use 6 for a hexagonal hole/easier printing)
cRefineHole = 6;
//to adjust for the blade position after rotation
cBladeOffset = 1; 
// Sweep angle for the blade
cSweepAngle = -3.5; 
// Base diameter
cBaseDia = 30; 
// Base thickness, this is the height of the base just before the cone part
cBaseThick = 3; 
// Base sweep thickness, this is the total length of the cone part of the base
cBaseSweepThick = 20; 
// Blade points
cBladePoints = [
    [0, 0],
    [cBladeDia, 0],
    [cBladeDia, cBladeLen / 2],
    [cBladeDia /2, cBladeLen],
    [0, cBladeLen],
    [0, 0]
];
// Functions

module shaft() {
    cylinder(d = cShaftDia, h = cShaftLen, $fn=cRefine);
}

module blade() {
    rotate([90, 0, 0]) {
        difference() {
            linear_extrude(height = cBladeThick) {
                polygon(points = cBladePoints);
            }
            translate([cBladeLen / 2, cBladeDia / 2, -1]) {
                rotate([0, 0, 90]) {
                    cylinder(d = cBladeHoleDia, h = cBladeThick + 2, $fn=cRefineHole);
                }
            }
        }
    }
}

module base() {
    cylinder(d = cBaseDia, h = cBaseThick, $fn=cRefine);
    translate([0, 0, cBaseThick]) {
        cylinder(d1 = cBaseDia, d2 = cShaftDia, cBaseSweepThick, $fn=cRefine);
    }
}

// Main
shaft();
translate([0, cBladeOffset, 0]) {
    rotate([cSweepAngle, 0, 0]) {
        blade();
    }
}
translate([0, -cBladeOffset, 0]) {
    rotate([0, 0, 180]) {
        rotate([cSweepAngle, 0, 0]) {
            blade();
        }
    }
}
base();