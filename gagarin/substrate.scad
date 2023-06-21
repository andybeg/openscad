$fn=10;

length = 400;
width= 400;
height = 3;
radius = 10;

dRadius = 2*radius;

difference() {
    minkowski() {
        cube(size=[width-dRadius,length-dRadius, height]);
        cylinder(r=radius, h=0.01);
    };
    for (i=[0:38]){ 
        for (j=[0:38]){
            translate([10*i,10*j,0])cylinder(r=2,h=10,$fn) ;
        }
    }
}