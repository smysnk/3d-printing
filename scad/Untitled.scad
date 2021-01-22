length = 25;
width = 15;
height = 5;
thickness = 0.4;

module cableHolder(length, width, height) {
    cube([length, width, thickness]);

    translate([-height, 0, -height])
        cube([length, width, thickness]);
    
    ribSegments = floor((length-height) / height);
    for (iteration = [0:ribSegments]) {
        ribLength =  height / sin(45);
        signedness = (iteration % 2 == 1) ? -1 : 1;
        translate([iteration * height, 0, height * (iteration % 2) - height])
            rotate([0, -45 * signedness, 0])
            cube([ribLength, width, thickness]);
    }
    
}

cableHolder(length, width, height);