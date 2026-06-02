// Вставка (проставка) под крыло: клин от 10 до 3 мм
// Габариты по фото: длина 20, высота 10, глубина (экструзия) 10
// Параметризовано для быстрой подгонки
$fn = 64;

// Основной модуль клина
module shim_wedge(length_mm = 20, height_left_mm = 10, height_right_mm = 3, depth_mm = 10, center_z = false) {
    linear_extrude(height = depth_mm, center = center_z)
        polygon(points = [
            [0, 0],                         // нижний левый
            [length_mm, 0],                 // нижний правый
            [length_mm, height_right_mm],   // верхний правый (тонкая сторона)
            [0, height_left_mm]             // верхний левый (толстая сторона)
        ],
        paths = [[0,1,2,3]]);
}

// Вызов для размеров из задания:
shim_wedge(length_mm = 20, height_left_mm = 10, height_right_mm = 3, depth_mm = 10, center_z = false);


