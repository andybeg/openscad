// Параметрическая коробочка с отверстием в дне и ушками сверху по длинным сторонам
$fn = 64;

// --- Внутренние размеры ---
inner_length = 50;   // мм (5 см)
inner_width  = 20;   // мм (2 см)
inner_height = 10;   // мм

// --- Стенки ---
wall = 2;            // мм

// --- Прямоугольное отверстие по центру дна ---
hole_length = 40;    // мм (4 см)
hole_width  = 15;    // мм (1.5 см)

// --- Ушки (по диагонали на длинных сторонах, сверху) ---
ear_hole_d = 2;                      // диаметр отверстия
ear_outer_d = ear_hole_d + 2;        // общий диаметр скруглённой части
ear_height  = wall;                  // высота ушка = толщина стенки
ear_join    = 0.2;                   // небольшое врезание в стенку для прочной склейки

// --- Производные ---
outer_length = inner_length + 2 * wall;
outer_width  = inner_width  + 2 * wall;
outer_height = inner_height + wall;  // дно + стенки, верх открыт

ear_r = ear_outer_d / 2;
ear_x_inset = ear_r;                 // отступ от торца вдоль длинной стороны
ear_z = outer_height - ear_height;   // на верхнем краю

module box_shell() {
    difference() {
        cube([outer_length, outer_width, outer_height]);
        translate([wall, wall, wall])
            cube([inner_length, inner_width, inner_height + 0.01]);
        // отверстие в дне (по центру)
        translate([
            (outer_length - hole_length) / 2,
            (outer_width  - hole_width)  / 2,
            -0.01
        ])
            cube([hole_length, hole_width, wall + 0.02]);
    }
}

// Ушко: прямые боковины от стенки + полукруг снаружи
// dir = -1: растёт в −Y (сторона y=0), dir = +1: в +Y (сторона y=outer_width)
// локально стенка в y=0, отверстие в центре скругления — вне корпуса
module ear(dir = -1) {
    // прямая часть: от врезки в стенку до центра отверстия
    rect_y0 = (dir < 0) ? -ear_r : -ear_join;
    difference() {
        union() {
            // скруглённый край
            translate([0, dir * ear_r, 0])
                cylinder(h = ear_height, d = ear_outer_d);
            // прямые боковины, касательные к окружности
            translate([-ear_r, rect_y0, 0])
                cube([ear_outer_d, ear_r + ear_join, ear_height]);
        }
        translate([0, dir * ear_r, -0.01])
            cylinder(h = ear_height + 0.02, d = ear_hole_d);
    }
}

module ears() {
    translate([ear_x_inset, 0, ear_z])
        ear(-1);
    translate([outer_length - ear_x_inset, outer_width, ear_z])
        ear(+1);
}

union() {
    box_shell();
    ears();
}
