///@description Click end
//action_do(Actions.tileData, objMain.current_layer, data)

if (!erase) {
	switch (type) {
		case Collision.spawningDisabled:
		case Collision.spawningEnabled:
			if (x0 == x1) {
				// Straight vertical
				var len = max(y0, y1) - min(y0, y1)
				y0 = min(y0, y1)
			
				collision_add(x0 * 16, y0 * 16, type, data)
				for (var i = 1; i <= len; i++) {
					collision_add(x0 * 16, (y0 + i) * 16, Collision.spawningDisabled, data)
				}
			} else if (y0 == y1) {
				// Straight horizontal
				var len = max(x0, x1) - min(x0, x1)
				x0 = min(x0, x1)
				for (var i = 0; i <= len; i++) {
					collision_add((x0 + i) * 16, y0 * 16, type, data)
				}
			} else {
				// Rectangle
				var len = max(x0, x1) - min(x0, x1)
				var tx = min(x0, x1)
				var ty0 = min(y0, y1)
				var ty1 = max(y0, y1)
				for (var i = 0; i <= len; i++) {
					collision_add((tx + i) * 16, ty0 * 16, type, data)
					collision_add((tx + i) * 16, ty1 * 16, Collision.spawningDisabled, data)
				}
				var len2 = max(y0, y1) - min(y0, y1) - 2
				var ty = min(y0, y1) + 1
				for (var i = 0; i <= len2; i++) {
					collision_add(x0 * 16, (ty + i) * 16, Collision.spawningDisabled, data)
					collision_add(x1 * 16, (ty + i) * 16, Collision.spawningDisabled, data)
				}
			}
		break
		default:
			var tx0 = min(x0, x1) * 16
			var tx1 = max(x0, x1) * 16
			var ty0 = min(y0, y1) * 16
			var ty1 = max(y0, y1) * 16
			for (var xx = tx0; xx <= tx1; xx += 16) {
				for (var yy = ty0; yy <= ty1; yy += 16) {
					collision_add(xx, yy, type, data)
				}
			}
	}
}

action_do(Actions.colData, erase, data)

instance_destroy()