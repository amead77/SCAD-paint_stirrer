// 2024-09-08 adam mead
//
// Paint Stirrer, 3d printable
//

// Variables

// Refinement level (for the shaft and cone)
cRefine = 32; 

/* [SHAFT] */
// Shaft diameter, larger diameter will allow for more sweep angle on the blades
cShaftDia = 7.95; 
// Shaft length, including the blades
cShaftLen = 100; 

/* [BLADE] */
// Blade diameter, each. 2x blade dia will be the overall width of the paddle
cBladeDia = 40; 
// Blade thickness
cBladeThick = 5; 
// Blade length (up the shaft)
cBladeLen = 50; 
//to adjust for the blade position after rotation
cBladeOffset = 1; 
// Sweep angle for the blade
cSweepAngle = -3.5; 

/* [BLADE HOLE] */
//Blade hole needed?
cBladeHole = true; //[true, false];
// Blade hole diameter
cBladeHoleDia = 14; 
// Refinement level for the blade hole (use 6 for a hexagonal hole/easier printing)
cRefineHole = 6;

/* [BASE && CONE] */
// Base diameter
cBaseDia = 30; 
// Base thickness, this is the height of the base just before the cone part
cBaseThick = 3; 
// Base sweep thickness, this is the total length of the cone part of the base going up the shaft
cBaseSweepThick = 20; 

/* [SHAFT RING] */
//Shaft ring wanted? For instance to add as a bearing stop
cShaftRing = true; //[true, false];
// Shaft ring diameter
cShaftRingDia = 10;
// Shaft ring thickness
cShaftRingThick = 2;

// Blade points, this uses the above to create the blade shape
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
            //chop out the hole
            if (cBladeHole) {
                translate([cBladeDia / 2, cBladeLen / 2, -1]) {
                    rotate([0, 0, 90]) {
                        cylinder(d = cBladeHoleDia, h = cBladeThick + 2, $fn=cRefineHole);
                    }
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

module shaftRing() {
    translate([0, 0, cBladeLen]) {
        cylinder(d = cShaftRingDia, h = cShaftRingThick, $fn=cRefine);
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
if (cShaftRing) {
    shaftRing();
}
