// 2024-09-08 adam mead
//
// Paint Stirrer, 3d printable
//

// Variables

cShaftDia = 8; // Shaft diameter
cShaftLen = 100; // Shaft length
cBladeDia = 50; // Blade diameter
cBladeThick = 5; // Blade thickness
cBladeLen = 50; // Blade length
cBladeHoleDia = 14; // Blade hole diameter
cRefine = 32; // Refinement level
cBladeOffset = 1; //to adjust for the blade position after rotation
cSweepAngle = -3.5; // Sweep angle for the blade
cBladePoints = [
    [0, 0],
    [cBladeLen, 0],
    [cBladeLen, cBladeDia / 2],
    [cBladeLen /2, cBladeDia],
    [0, cBladeDia],
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
                    cylinder(d = cBladeHoleDia, h = cBladeThick + 2, $fn=6);
                }
            }
        }
    }
}

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