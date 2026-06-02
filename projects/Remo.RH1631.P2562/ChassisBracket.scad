fn = 100;
barx = 4.7;
bary = barx;
barz1 = 25;
offset = 14/2;
cylinderD =4.3;
cylinderH = 8;
cylinderTopRoundR = 2;
cylinderDistance = 55;
barz2 = offset + barx;
holeD1 = 2;
holeH1 = 5;
holeD2 = 1.5;
holeH2 = 5;
edgeRoundD = 1;
edgeRoundR = edgeRoundD / 2;
module rounded_bar_z(x, y, z, r) {
    hull() {
        translate([r, r, 0]) cylinder(h = z, r = r, $fn = fn);
        translate([x - r, r, 0]) cylinder(h = z, r = r, $fn = fn);
        translate([r, y - r, 0]) cylinder(h = z, r = r, $fn = fn);
        translate([x - r, y - r, 0]) cylinder(h = z, r = r, $fn = fn);
    }
}

module rounded_bar_x(x, y, z, r) {
    hull() {
        translate([0, r, r]) rotate([0, 90, 0]) cylinder(h = x, r = r, $fn = fn);
        translate([0, y - r, r]) rotate([0, 90, 0]) cylinder(h = x, r = r, $fn = fn);
        translate([0, r, z - r]) rotate([0, 90, 0]) cylinder(h = x, r = r, $fn = fn);
        translate([0, y - r, z - r]) rotate([0, 90, 0]) cylinder(h = x, r = r, $fn = fn);
    }
}

module first_bar() {
    difference() {
        rounded_bar_z(barx, bary, barz1, edgeRoundR);
        for (z = [barx / 2 : barx : barz1 - barx / 2]) {
            translate([barx / 2, bary / 2, z])
                rotate([90, 0, 0]) cylinder(d = holeD1, h = holeH1, $fn = fn, center = true);
        }
    }
}

module second_bar() {
    difference() {
        rounded_bar_x(barz2, bary, barx, edgeRoundR);
    }
}

module first_cylinder() {
    cylR = cylinderD / 2;
    topRoundR = min(cylinderTopRoundR, cylR, cylinderH);
    arcSteps = max(6, ceil(fn / 8));
    arcPoints = [
        for (i = [0 : arcSteps])
            let(a = i * 90 / arcSteps)
                [
                    (cylR - topRoundR) + topRoundR * cos(a),
                    (cylinderH - topRoundR) + topRoundR * sin(a)
                ]
    ];

    difference() {
        rotate_extrude($fn = fn)
            polygon(points = concat(
                [[0, 0], [cylR, 0], [cylR, cylinderH - topRoundR]],
                arcPoints,
                [[0, cylinderH]]
            ));
        for (z = [cylinderH / 3, 2 * cylinderH / 3]) {
            translate([0, 0, z])
                rotate([90, 0, 0]) cylinder(d = holeD2, h = holeH2, $fn = fn, center = true);
        }
    }
}

module bracket() {
    cubeBaseX = cylinderDistance / 2 - barx / 2;

    translate([0, 0, barz1]) second_bar();
    translate([offset, 0, 0]) first_bar();
    translate([cubeBaseX, 0, barz1 + barx]) cube([barx, barx, barx]);

    // Bridge near cube edges with the end face of second_bar.
    hull() {
        translate([barz2 - 0.01, 0, barz1]) cube([0.02, barx, barx]);
        translate([cubeBaseX, 0, barz1 + barx]) cube([0.02, barx, barx]);
    }

    translate([cylinderDistance / 2, barx / 2, barz1 + 2*barx]) first_cylinder();
}

bracket();
mirror([1, 0, 0]) bracket();
