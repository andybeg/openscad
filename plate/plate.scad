$fn=100;
holesX = 11;
holesY = 20;
holeR = 2.75/2;
bigHoleR = 3.5;
boxX = bigHoleR*2 * holesX;
boxY = bigHoleR*2 * holesY;
boxZ = 3;

// Raspberry Pi mounting hole patterns (center-to-center, mm)
rpi_dx = 58;
rpi_dy = 49;
rpi_zero_dx = 58;
rpi_zero_dy = 23;
include_zero = true;

// Uniform grid steps (mm) aligned to Raspberry Pi mounting pattern.
// Choose stepX so that 58mm is an integer number of steps (more columns between the 2 mount columns).
grid_divX = 8;              // 58mm / 8 = 7.25mm (gives 9 columns across 71mm width with current anchor)
grid_divY = 7;              // 49mm / 7 = 7mm
grid_stepX = rpi_dx / grid_divX;
grid_stepY = rpi_dy / grid_divY;

module mounting_holes(dx, dy, r=holeR){
    innerX = boxX - bigHoleR*2;
    innerY = boxY - bigHoleR*2;
    x0 = (innerX - dx) / 2;
    y0 = (innerY - dy) / 2;
    for (sx=[0,1]){
        for (sy=[0,1]){
            translate([x0 + sx*dx, y0 + sy*dy, -2]) cylinder(h=5, r=r, $fn);
        }
    }
}

module anchored_grid_holes(stepX, stepY, anchorX, anchorY, sizeX, sizeY, r=holeR){
    ix_min = floor((-anchorX)/stepX) - 1;
    ix_max = ceil((sizeX - anchorX)/stepX) + 1;
    iy_min = floor((-anchorY)/stepY) - 1;
    iy_max = ceil((sizeY - anchorY)/stepY) + 1;

    for (ix=[ix_min:ix_max]){
        for (iy=[iy_min:iy_max]){
            translate([anchorX + ix*stepX, anchorY + iy*stepY, -2])
                cylinder(h=5, r=r, $fn);
        }
    }
}
module plate(){
    minkowski() {
    cube([boxX - bigHoleR*2,boxY - bigHoleR*2,boxZ],false);
    cylinder(r=bigHoleR, h=0.01);
    };
}
difference(){
    translate([bigHoleR,bigHoleR,0]) plate();

    // Grid anchored so that Raspberry Pi mounting holes land on grid nodes.
    innerX = boxX - bigHoleR*2;
    innerY = boxY - bigHoleR*2;
    rpi_x0 = (innerX - rpi_dx) / 2;
    rpi_y0 = (innerY - rpi_dy) / 2;
    translate([bigHoleR,bigHoleR,0])
        anchored_grid_holes(grid_stepX, grid_stepY, rpi_x0, rpi_y0, innerX, innerY);

    // Optional: also keep Raspberry Pi Zero mounting holes.
    if (include_zero) translate([bigHoleR,bigHoleR,0]) mounting_holes(rpi_zero_dx, rpi_zero_dy);
}
