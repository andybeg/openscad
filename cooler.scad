// Параметры винта кулера
outer_diameter = 50; // 5см в миллиметрах
inner_diameter = 15; // 1.5см в миллиметрах
height = 3; // высота винта
blade_count = 40; // количество лопастей
blade_thickness = 1; // толщина лопасти

// Внутреннее отверстие
cylinder(h=height+2, d=inner_diameter, $fn=50);
    
// Лопасти винта
for(i = [0:blade_count-1]) {
    rotate([0, 0, i * (360/blade_count)])
    translate([inner_diameter/2.5, 0, 0])
    rotate([30, 0, 45])
    cube([outer_diameter/2, blade_thickness, height+2]);
}

