// Width of back wall (so that screw will sit flush)
backWallWidth = 3;

// Width of the walls
wallWidth = 2;

// Length of the brick
length = 23;

// Width of the brick
width = 50.5;

// Height of the holder
height = 90;

// Bottom lip protrusion
bottomLip = 2;

// A little bit larger than the threads
screwDiameter = 4;

// Chamfer angle of the top
chamferAngle = 30;

$fn=20;

module mainBox() {
  difference() {
    // Body
    cube([length + backWallWidth + wallWidth, width + (wallWidth * 2), height + wallWidth]);

    // Main Cutout
    translate([backWallWidth, wallWidth, wallWidth + 0.1]) 
      cube([length, width, height]);
    
    // Bottom Lip Cutout
    translate([backWallWidth + bottomLip, wallWidth + bottomLip, -0.1])
      cube([length - (bottomLip * 2), width - (bottomLip * 2), height]);
    
    // Top Box Chamfer
    translate([0, -0.1, height + backWallWidth]) 
      rotate([0, chamferAngle, 0])
      cube([height * 2, width + (wallWidth * 2) + 0.2, length]);
    
    // Cutout front air vent
    cutoutWidth = (width / 4) * 3;
    translate([wallWidth + length - 0.1, wallWidth + (width - cutoutWidth) / 2, height / 4])
      cube([length, cutoutWidth, height]);
    
    // Cutout side air vents
    cutoutLength = (length / 4) * 2;
    translate([wallWidth + (length - cutoutLength) / 2, -0.1, height / 4])
      cube([cutoutLength, width * 2, height]);

    
    // Screws
    screwHole([0, wallWidth + (width / 4) * 1, wallWidth + (height / 4) * 1]);
    screwHole([0, wallWidth + (width / 4) * 1, wallWidth + (height / 4) * 3]);
    screwHole([0, wallWidth + (width / 4) * 3, wallWidth + (height / 4) * 1]);
    screwHole([0, wallWidth + (width / 4) * 3, wallWidth + (height / 4) * 3]);
    
  }
}


module screwHole(position) {
  // Main screw hole
  translate([position[0] - 0.1, position[1], position[2]])
    rotate([0, 90, 0])
    cylinder(5, d=screwDiameter);  
  
  // Screw hole chamfer
  translate([position[0] + (backWallWidth / 4), position[1], position[2]])
    rotate([0, 90, 0])
    cylinder(backWallWidth, d1=screwDiameter, d2=screwDiameter * 2);    

}

mainBox();
