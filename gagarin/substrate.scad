$fn=100;

// Параметры отверстий
dotsX = 7;  // количество отверстий по X
dotsY = 7;  // количество отверстий по Y
dotSpacing = 10;  // расстояние между центрами отверстий
dotRadius = 2;  // радиус отверстий

// Параметры подложки
height = 3;  // высота подложки
radius = 5;  // радиус скругления углов

// Вычисляемые размеры
margin = dotSpacing/2;  // отступ от краев = половина расстояния между отверстиями
width = 2*margin + (dotsX-1)*dotSpacing;
length = 2*margin + (dotsY-1)*dotSpacing;

difference() {
    // Создаем подложку со скругленными углами
    hull() {
        translate([radius, radius, 0])
            cylinder(r=radius, h=height);
        translate([width-radius, radius, 0])
            cylinder(r=radius, h=height);
        translate([radius, length-radius, 0])
            cylinder(r=radius, h=height);
        translate([width-radius, length-radius, 0])
            cylinder(r=radius, h=height);
    }
    
    // Вычитаем отверстия
    for (i=[0:(dotsX-1)]){ 
        for (j=[0:(dotsY-1)]){
            translate([margin + i*dotSpacing, margin + j*dotSpacing, -0.1])
                cylinder(r=dotRadius, h=height+0.2);
        }
    }
}