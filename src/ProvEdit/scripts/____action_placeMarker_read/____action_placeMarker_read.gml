var b = argument0;

var tx = buffer_read(b, buffer_s32)
var ty = buffer_read(b, buffer_s32)
var ti = buffer_read(b, buffer_u16)

if (!argument1) {
	global.marker[ti] = instance_create_depth(tx, ty, -999, objMarker)
	global.marker[ti].idx = ti
} else {
	instance_destroy(global.marker[ti])
}