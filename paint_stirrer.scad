// 2024-09-08 adam mead
//
// Paint Stirrer
//

// Variables

cShaftDia = 8; // Shaft diameter
cShaftLen = 100; // Shaft length
cBladeDia = 50; // Blade diameter
cBladeThick = 5; // Blade thickness
cBladeLen = 50; // Blade length
cBladeHoleDia = 10; // Blade hole diameter
cRefine = 32; // Refinement level
cBladeOffset = 1; //to adjust for the blade position after rotation

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
                cylinder(d = cBladeHoleDia, h = cBladeThick + 2, $fn=cRefine);
            }
        }
    }
}

shaft();
translate([0, cBladeOffset, 0]) {
    blade();
}
translate([0, -cBladeOffset, 0]) {
    rotate([0, 0, 180]) {
        blade();
    }
}