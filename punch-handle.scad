// Цилиндр для ручки пробойника

// Параметры основного цилиндра
length = 100;  // Длина: 10 см (100 мм)
diameter = 20; // Диаметр: 20 мм

// Параметры малых цилиндров
small_diameter = 5;   // Диаметр: 5 мм
small_radius = small_diameter / 2; // Радиус для сфер

// Расстояние между цилиндрами
distance = 100; // 10 см (100 мм)

// Высота связующих фигур
transition_height = 10; // 10 мм

// Смещение для высоты малых цилиндров
small_cylinder_offset = 10; // 10 мм

// Высота малых цилиндров (связующая фигура + смещение)
small_length = transition_height + small_cylinder_offset;

fn = 100;      // Количество граней для гладкости

// Поворот всей фигуры на 90° и размещение так, чтобы касалась горизонтальной плоскости
translate([0, 0, diameter/2])
rotate([0, 90, 0]) {
    // Основной цилиндр
    cylinder(h = length, d = diameter, center = false, $fn = fn);

    // Переходная фигура между большим цилиндром и нижним малым цилиндром
    hull() {
        // Точка на основании большого цилиндра
        translate([0, 0, 0])
            cylinder(h = transition_height, d = diameter, center = false, $fn = fn);
        // Точка на основании малого цилиндра (на той же плоскости z=0)
        translate([distance, 0, 0])
            cylinder(h = transition_height, d = small_diameter, center = false, $fn = fn);
    }

    // Малый цилиндр внизу - привязан к верхней грани связующей фигуры
    translate([distance, 0, transition_height - small_length]) {
        union() {
            // Цилиндр
            cylinder(h = small_length, d = small_diameter, center = false, $fn = fn);
            // Сфера на нижнем конце
            sphere(r = small_radius, $fn = fn);
        }
    }

    // Переходная фигура между большим цилиндром и верхним малым цилиндром
    hull() {
        // Точка на верхнем конце большого цилиндра
        translate([0, 0, length - transition_height])
            cylinder(h = transition_height, d = diameter, center = false, $fn = fn);
        // Точка на верхнем малом цилиндре
        translate([distance, 0, length - transition_height])
            cylinder(h = transition_height, d = small_diameter, center = false, $fn = fn);
    }

    // Малый цилиндр вверху - привязан к нижней грани связующей фигуры
    translate([distance, 0, length - transition_height]) {
        union() {
            // Цилиндр
            cylinder(h = small_length, d = small_diameter, center = false, $fn = fn);
            // Сфера на верхнем конце
            translate([0, 0, small_length])
                sphere(r = small_radius, $fn = fn);
        }
    }
}
