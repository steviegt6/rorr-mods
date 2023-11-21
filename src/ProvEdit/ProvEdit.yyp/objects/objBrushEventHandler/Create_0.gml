space_covered = ds_map_create()

data = []
count = 0
x0 = 0
y0 = 0
x1 = 0
y1 = 0
size = objMain.tool_tile_brush_size

createleft = true
createright = true
createtop = true
createbottom = true
written = ds_map_create()
overwritten = ds_map_create()
layer_id = objMain.current_layer