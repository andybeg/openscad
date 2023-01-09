/* Captive Nut Knob

by Nat Blundell <nat@tepic.co.uk>

May 2022


This work is licensed under the Creative Commons Attribution 4.0 International
License. To view a copy of this license, visit
http://creativecommons.org/licenses/by/4.0/ or send a letter to Creative
Commons, PO Box 1866, Mountain View, CA 94042, USA.


2022-05-16  Version 1  Initial release.
*/



/* [Main settings] */

// The height of the knob, without any stand off
Knob_Height = 20.0; // [5.0:0.5:50.0]

// The outer diameter of the knob
Knob_Diameter = 40.0; //[20:0.5:100.0]

// How many "gripping flutes" (knurls)
Flutes = 5; // [0:1:50]

// Do the flutes got the full height of the knob?
Full_Height_Flutes = false;

// Stand off. Built in "washer" or "stalk".
Stand_Off_Height = 2.0; // [0.0:0.5:30.0]

// Stand off diameter
Stand_Off_Diameter = 15.0; // [10:0.5:50.0]

// Screw/Threaded rod diameter
Screw_Diameter = 6.0;  // [3.0:0.1:12.0]

// Nut diameter, measured across opposite flats
Nut_Width = 9.8; // [5.0:0.1:25.0]

// How much knob beneath the nut
Nut_Seat_Height = 4; // [1.0:0.5:49.0]


/* [Expert Mode] */

$fn = 50;  // [5:5:200]

// Fillet radius
Fillet = 3.5;  // [0.1:0.1:5.0]

// As a percentage of flute diameter
Flute_Depth = 25; // [10:1:50]

// Clearance for the screw hole
Screw_Clearance = 0.2; // [0.0:0.1:1.0]

// Clearance for the nut (this should be a tight fit)
Nut_Clearance = 0.0; // [-0.5:0.1:1.0]


/* [Hidden] */

THETA = 360/Flutes;

FLUTE_D = (PI*Knob_Diameter) / (Flutes*2);

full_flutes = Fillet > FLUTE_D ? true : Full_Height_Flutes;



difference() {
    union() {
        // Main body
        minkowski() {
            translate([0, 0, Fillet/2]) cylinder(d=Knob_Diameter-Fillet, h=Knob_Height-Fillet);
            sphere(d=Fillet);
        }

        // Standoff
        if (Stand_Off_Height > 0) {
            translate([0, 0, -Stand_Off_Height]) cylinder(d=Stand_Off_Diameter, h=Stand_Off_Height);
        }
    }

    // Though hole
    translate([0, 0, -Stand_Off_Height-1]) cylinder(d=Screw_Diameter+Screw_Clearance, h=Stand_Off_Height+Knob_Height+2);

    // Nut recess
    nut_d = Nut_Width / cos(30) + Nut_Clearance;
    translate([0, 0, Nut_Seat_Height])
    cylinder(d=nut_d, h=Knob_Height, $fn=6);

    // Flutes
    if (Flutes > 0) {
        flute_offset = Knob_Diameter/2+FLUTE_D*(50 - Flute_Depth)/100;
        flute_height = full_flutes ? -1 : Fillet;
        for (i=[1:Flutes]) {
            rotate([0, 0, THETA*i])
            translate([flute_offset, 0, flute_height])
            if (full_flutes) {
                cylinder(d=FLUTE_D, h=Knob_Height+2);
            } else {
                minkowski() {
                    cylinder(d=FLUTE_D-Fillet, h=Knob_Height);
                    sphere(d=Fillet);
                }
            }
        }
    }
}