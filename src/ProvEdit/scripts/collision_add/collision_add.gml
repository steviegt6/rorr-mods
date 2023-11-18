
if (argument2 < 0) {
	var col = collision_point(argument0 + 8, argument1 + 8, parCollisionAll, false, false)
	if !col
		exit

	ds_list_add(argument3, col.type)
	ds_list_add(argument3, argument0)
	ds_list_add(argument3, argument1)
	
	with col
		instance_destroy()
} else {
	if (argument2 == Collision.rope || argument2 == Collision.bossSpawn || argument2 == Collision.bossSpawn2) {
		if collision_point(argument0 + 8, argument1 + 8, global.collision_types[argument2, CollisionType.object], false, false)
			exit
	} else {
		if collision_point(argument0 + 8, argument1 + 8, parCollisionSolid, false, false)
			exit
	}
	
	ds_list_add(argument3, argument2)
	ds_list_add(argument3, argument0)
	ds_list_add(argument3, argument1)
}