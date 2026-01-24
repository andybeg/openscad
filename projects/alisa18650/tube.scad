// Труба с сеточкой для Яндекс Станции Мини 2
// Mesh tube for Yandex Station Mini 2
// Диаметр основан на Alisa Bottom case.scad (r=45)

// Параметры
outer_radius = 45;      // Внешний радиус (из Alisa Bottom case)
wall_thickness = 2;     // Толщина стенки
tube_height = 50;       // Длина трубы
inner_radius = outer_radius - wall_thickness;

// Параметры сетки
mesh_hole_diameter = 4; // Диаметр отверстий сетки
mesh_spacing = 6;       // Расстояние между центрами отверстий
mesh_rows = 8;          // Количество рядов по высоте

fn = 100;

module mesh_tube() {
    difference() {
        union() {
            // Основная труба
            cylinder(h = tube_height, r = outer_radius, center = false, $fn = fn);
            
            // Дно трубы
            cylinder(h = wall_thickness, r = outer_radius, center = false, $fn = fn);
        }
        
        // Внутренняя полость (начинается после дна)
        translate([0, 0, wall_thickness])
        cylinder(h = tube_height + 1, r = inner_radius, center = false, $fn = fn);
        
        // Создание сетки из отверстий
        for (row = [0:mesh_rows-1]) {
            z_pos = mesh_spacing + row * mesh_spacing;
            // Количество отверстий в ряду зависит от радиуса
            holes_in_row = floor(2 * PI * outer_radius / mesh_spacing);
            
            for (i = [0:holes_in_row-1]) {
                angle = i * (360 / holes_in_row);
                // Смещение четных рядов для лучшего паттерна
                offset_angle = (row % 2 == 0) ? 0 : (180 / holes_in_row);
                
                rotate([0, 0, angle + offset_angle])
                translate([outer_radius - wall_thickness/2, 0, z_pos])
                rotate([0, 90, 0])
                cylinder(h = wall_thickness + 1, r = mesh_hole_diameter/2, center = true, $fn = 20);
            }
        }
    }
}

// Рендерим трубу с сеточкой
mesh_tube();
