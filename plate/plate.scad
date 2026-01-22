$fn=100;
holesX = 11;
holesY = 20;
holeR = 2.75/2;
bigHoleR = 3.5;
boxX = bigHoleR*2 * holesX;
boxY = bigHoleR*2 * holesY;
boxZ = 3;
stepX = boxX/holesX;
stepY = boxY/holesY;
startX = stepX/2;
startY = stepY/2;
module plate(){
    minkowski() {
    cube([boxX - bigHoleR*2,boxY - bigHoleR*2,boxZ],false);
    cylinder(r=bigHoleR, h=0.01);
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
    translate([bigHoleR,bigHoleR,0]) plate();
    holes();
}
