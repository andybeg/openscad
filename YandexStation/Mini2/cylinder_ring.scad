// Units: mm
// Main disk Ø92 × 3, center hole Ø51
// Bottom: cut rectangular ring OD92 / ID90 × 1.5
// Top: add same ring
// 5 mount holes matching Yandex Station Mini 2 base
// Spacings: 60°, 60°, 60°, 90°, 90°

$fn = 180;

od          = 92;   // outer diameter
h           = 3;    // main height
hole_d      = 51;   // center hole
ring_od     = 92;
ring_id     = 90;
ring_h      = 1.5;

// Mount holes: radius ~38 mm, Ø3.5
// Spacings: 60°, 60°, 60°, 90°, 90°
mount_r     = 38;
mount_d     = 3.5;
mount_angles = [0, 60, 120, 180, 270];

module rect_ring(outer_d, inner_d, height) {
    difference() {
        cylinder(d = outer_d, h = height);
        translate([0, 0, -0.1])
            cylinder(d = inner_d, h = height + 0.2);
    }
}

module mount_holes(height) {
    for (a = mount_angles)
        rotate([0, 0, a])
            translate([mount_r, 0, -0.1])
                cylinder(d = mount_d, h = height + 0.2);
}

difference() {
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

    mount_holes(h + ring_h);
}
