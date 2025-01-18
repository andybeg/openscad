holesX = 10;
holesY = 20;
holeR = 2;
boxX = 75-2*holeR;
$fn=100;
boxY = 140-2*holeR;
boxZ = 3;
stepX = boxX/holesX;
stepY = boxY/holesY;
startX = stepX/2;
startY = stepY/2;
module plate(){
    minkowski() {
    cube([boxX,boxY,boxZ],false);
    cylinder(r=2, h=0.01);
    };
}
module holes(){
    for(x=[0:holesX-1]){
        for(y=[0:holesY-1]){
            translate([startX+x*stepX,startY+y*stepY,-2]) cylinder(h=5,r=holeR,$fn);
        }
    }

}
difference(){
    plate();
    holes();
}
