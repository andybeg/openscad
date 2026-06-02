$fn = 100;

difference() {
  union() {
    translate([3, 0, 0]) cube([20, 10, 10]);
    translate([0, -10, 0]) cube([10, 10, 10]);
    translate([18, -5, 0]) cube([5, 5, 10]);
    translate([0, -30, -3]) cube([5, 30, 5]);
    mirror([1, 0, 0]) {
      translate([3, 0, 0]) cube([20, 10, 10]);
      translate([0, -10, 0]) cube([10, 10, 10]);
      translate([18, -5, 0]) cube([5, 5, 10]);
      translate([0, -30, -3]) cube([5, 30, 5]);
    }
  }
  translate([0, -20, -20]) cylinder(d=5, h=30);
}
