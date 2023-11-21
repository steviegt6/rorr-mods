gml_pragma("global", @'
	global.collision_types[0, 0] = "Spawning Disabled"
	global.collision_types[0, 1] = c_orange
	global.collision_types[0, 2] = objCollisionWall
	global.collision_types[0, 3] = "BNoSpawn"
	global.collision_types[1, 0] = "Spawning Enabled"
	global.collision_types[1, 1] = c_aqua
	global.collision_types[1, 2] = objCollisionFloor
	global.collision_types[1, 3] = "B"
	global.collision_types[2, 0] = "Rope"
	global.collision_types[2, 1] = c_yellow
	global.collision_types[2, 2] = objCollisionRope
	global.collision_types[2, 3] = "Rope"
	global.collision_types[3, 0] = "Boss Spawn"
	global.collision_types[3, 1] = $DC00FF
	global.collision_types[3, 2] = objCollisionBoss
	global.collision_types[3, 3] = "BossSpawn"
	global.collision_types[4, 0] = "Boss Spawn 2"
	global.collision_types[4, 1] = $FF0048
	global.collision_types[4, 2] = objCollisionBoss2
	global.collision_types[4, 3] = "BossSpawn2"
	global.collision_types[5, 0] = "Lava"
	global.collision_types[5, 1] = c_maroon
	global.collision_types[5, 2] = objCollisionLava
	global.collision_types[5, 3] = "Lava"
	global.collision_types[6, 0] = "Slowing"
	global.collision_types[6, 1] = c_lime
	global.collision_types[6, 2] = objCollisionSlow
	global.collision_types[6, 3] = "Slow"
	global.collision_type_num = 7
	/*global.collision_types[4, 0] = "Custom Buff"
	global.collision_types[4, 1] = c_white
	global.collision_types[4, 2] = objCollisionFloor*/
')
sprite_index = -1

enum Collision {
	spawningDisabled,
	spawningEnabled,
	rope,
	bossSpawn,
	bossSpawn2,
	lava,
	slow,
}


enum CollisionType {
	name,
	colour,
	object,
	rorObject
}