$fn=100;
dimX=70;
dimY=50;

length = dimX;
width= dimY;
height = 3;
radius = 10;
dots=10;
dRadius = 2*radius;
difference() {
    minkowski() {
        cube(size=[width-dRadius,length-dRadius, height]);
        cylinder(r=radius, h=0.01);
    };
    for (i=[0:(dots-1)]){ 
        for (j=[0:(dots-1)]){
            translate([10*i,10*j,0])cylinder(r=2,h=10,$fn) ;
        }
    }
}