// Units: mm
// Main disk Ø92 × 3, center hole Ø51
// Bottom: cut rectangular ring OD92 / ID90 × 1.5
// Top: add same ring

$fn = 180;

od          = 92;   // outer diameter
h           = 3;    // main height
hole_d      = 51;   // center hole
ring_od     = 92;
ring_id     = 90;
ring_h      = 1.5;

module rect_ring(outer_d, inner_d, height) {
    difference() {
        cylinder(d = outer_d, h = height);
        translate([0, 0, -0.1])
            cylinder(d = inner_d, h = height + 0.2);
    }
}

union() {
    // Main body with center hole and bottom groove
    difference() {
        cylinder(d = od, h = h);
        translate([0, 0, -0.1])
            cylinder(d = hole_d, h = h + 0.2);
        // Bottom rectangular-section ring cutout
        translate([0, 0, -0.01])
            rect_ring(ring_od, ring_id, ring_h + 0.01);
    }

    // Top rectangular-section ring
    translate([0, 0, h])
        rect_ring(ring_od, ring_id, ring_h);
}
