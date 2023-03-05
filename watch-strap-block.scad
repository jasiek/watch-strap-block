$fn = 20;

// Size of block (square), in mm
Edge_Length = 53;

// Height of block (mm)
Height = 23;

// Diagonal slot width (mm)
Diagonal_Slot_Width = 3.5;

// Grid slot width (mm)
Grid_Slot_Width = 3.2;

// How far from edge to place drilling holes (mm)
Drilling_Offset = 8;

// Drilling hole diameter (mm)
Drilling_Hole_Diameter = 2;

module solid_block(edge_length,
                   height,
                   drilling_offset,
                   hole_width) {
    linear_extrude(height=height) {
        difference() {
            // solid octagonal block
            polygon(points=[
                [0, 5],
                [0, edge_length - 5],
                [5, edge_length],
                [edge_length - 5, edge_length],
                [edge_length, edge_length - 5],
                [edge_length, 5],
                [edge_length - 5, 0],
                [5, 0]
            ]);
            
            // Drilling/mounting holes
            for(x=[drilling_offset, edge_length - drilling_offset])
                for(y=[drilling_offset, edge_length - drilling_offset])
                    translate([x, y]) circle(hole_width);
            translate([edge_length / 2,
                       edge_length / 2]) circle(hole_width);
       }
    }
}

module block_slots(edge_length,
                   height,
                   diagonal_slot_width,
                   edge_slot_width) {
        height = height + 0.1;
        
        translate([edge_length / 2,
                   edge_length / 2,
                   height / 2]) {
            for (rot=[0:90:360]) {
                rotate([0, 0, rot]) {
                   translate([-edge_length / 2 + 8, -edge_length / 2, 0])
                        cube([edge_slot_width, edge_length, height / 2]);
                   
                   translate([-edge_slot_width / 2, 0, 0])
                        cube([edge_slot_width, edge_length, height / 2]);
                   
                }
            }
                   
            for (rot=[45:90:360])
                rotate([0, 0, rot])
                    translate([-diagonal_slot_width / 2, 0, 0])
                    cube([diagonal_slot_width, edge_length, height / 2]);
        }
}

module strap_block(edge_length,
                    height,
                    diagonal_slot_width,
                    edge_slot_width,
                    drilling_offset,
                    hole_width) {
                    // Print sizes
                    translate([edge_length / 2 + 3, 2, height]) text(text=str(diagonal_slot_width), size=edge_length/12);
                    
                    translate([edge_length - 2, 12, height]) rotate([0, 0, 90]) text(text=str(edge_slot_width), size=edge_length/12);

                    difference() {
              solid_block(edge_length,
                       height,
                       drilling_offset,
                       hole_width);
                block_slots(edge_length,
                            height,
                            diagonal_slot_width,
                            edge_slot_width);
                            }

}

strap_block(edge_length=Edge_Length,
            height=Height,
            diagonal_slot_width=Diagonal_Slot_Width,
            edge_slot_width=Grid_Slot_Width,
            drilling_offset=Drilling_Offset,
            hole_width=Drilling_Hole_Diameter);