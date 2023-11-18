
lv_left = -LV_WIDTH_DEFAULT / 2
lv_right = LV_WIDTH_DEFAULT / 2
lv_top = -LV_HEIGHT_DEFAULT / 2
lv_bottom = LV_HEIGHT_DEFAULT / 2

global.view_x = lv_left
global.view_y = lv_top - 16 * global.view_zoom

global.level_name = "Unnamed Level"
global.level_subname = ""
global.level_music = 0 // Silence

global.tiles = []

global.layers_total = 0
select_layer(layer_add("Layer 1", 0, 12))

global.level_path = ""

global.level_enemies = []
global.level_map_objects = []
global.level_backgrounds = []