///@function ____net_pack_action(buffer, undo)
///@param buffer id
///@param undo bool
function ____net_pack_action(argument0, argument1) {

	var buffer = buffer_create(buffer_get_size(argument0) + 2, buffer_fixed, 1)

	buffer_write(buffer, buffer_u8, NetPacket.action)
	buffer_write(buffer, buffer_u8, argument1)

	buffer_copy(argument0, 0, buffer_get_size(argument0), buffer, 2)

	return buffer



}
