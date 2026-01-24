// Нижняя крышка Яндекс Станции Мини 2
// Bottom cover for Yandex Station Mini 2
fn = 10000;

module bottom_cover() {
    difference() {
        // Основание крышки - основная форма
        union() {
            // Центральная часть - круглая основа
            cylinder(h = 3, r = 45, center = false, $fn = 100);
            
            // Боковые стенки для крепления
            translate([0, 0, 3])
            cylinder(h = 8, r = 43, center = false, $fn = 100);
            
            // Бугорок для перенаправления звука (центральный элемент)
            translate([0, 0, 3])
            cylinder(h = 5, r = 8, $fn = 50);
        }
        
        // Внутренняя полость
        translate([0, 0, 1])
        cylinder(h = 10, r = 41, center = false, $fn = 100);
        
        // Отверстия для винтов крепления (5 штук)
        for (i = [0:4]) {
            rotate([0, 0, i * 72])
            translate([35, 0, -0.5])
            cylinder(h = 5, r = 1.5, $fn = 16);
        }
        
        // Углубления для головок винтов
        for (i = [0:4]) {
            rotate([0, 0, i * 72])
            translate([35, 0, 2])
            cylinder(h = 2, r = 3, $fn = 16);
        }
        
        // Паз для кабеля питания
        translate([40, -3, -0.5])
        cube([10, 6, 4]);
    }
}
// Рендерим крышку
bottom_cover();
