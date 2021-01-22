length = 152;
width = 15;
wallWidth = 2;
//height = 37.5;

webs = 14;
holeRadius = 2.2;
holeRows = 2.1;
holesPerWeb = 1.0;

$fn = 20;

trussByWebs(length, width, wallWidth, webs, holeRadius=holeRadius, holeRows=holeRows);
translate([0, 15, 0])
  rotate([180, 90, 0])
  trussByWebs(length, width, wallWidth, webs, holeRadius=holeRadius, holeRows=holeRows);

module trussByWebs(length, width, wallWidth, webs, holesPerWeb=holesPerWeb, holeRadius=3, holeRows=2) {
  
  websSafe = floor(webs / 2) * 2;
  div = length / websSafe; 
  
  difference() {
    union() {
      // Top
      cube([length, width, wallWidth]);
                    
      // Bottom
      translate([div, 0, -div])
        cube([length, width, wallWidth]);
      
      createWebs(div, width, wallWidth, websSafe);

      // Fix missing wedge, top right
      translate([length, width, 0])
        rotate([90,0,0])
        topRightWedge(width, wallWidth);
      
      // Fix missing wedge, bottom right
      translate([div * (websSafe + 1), width, -div])
        rotate([90,45,0])
        bottomRightWedge(width, wallWidth);
      
    }
    
    holeOffsetY = width / (holeRows);
    holeOffsetX = div / holesPerWeb;
    for (y = [0 : holeRows - 1]) {
      for (x = [0 : (websSafe * holesPerWeb)]) { 
        translate([(holeOffsetX / 2) + holeOffsetX * x, (holeOffsetY * y) + (holeOffsetY / 2) , -25])
          cylinder(h=100, r=holeRadius, center=true);
      }
      
      translate([0, (holeOffsetY * y) + (holeOffsetY / 2), -(div - wallWidth)/2])
        rotate([0, 90,0])
        cylinder(h=length+50, r=holeRadius);
    }
  }
}

module bottomRightWedge(width, wallWidth) {
  hyp = sin(45) * wallWidth;
  linear_extrude(height = width, convexity = 10, twist = 0)
    polygon(points=[[0, 0], [0, wallWidth], [wallWidth, wallWidth]]);  
}

module topRightWedge(width, wallWidth) {
  hyp = sin(45) * wallWidth;  
  linear_extrude(height = width, convexity = 10, twist = 0)
    polygon(points=[[0, 0], [0, wallWidth], [hyp, hyp]]);
}
  
module createWebs(height, width, wallWidth, webs) {
  for (i = [0 : webs]) {    
    signedness = (i % 2 == 0) ? 1 : -1;  
    translate([height * i, 0, -height * (i % 2)])
      rotate([0, 45 * signedness, 0])
      cube([height / sin(45), width, wallWidth]);     
  } 
}

 
 
// length = height * (2 * webs + 1)

// 150 / 2 * 2 + 1 = height


// 150 / (2 * 3) = height
  



