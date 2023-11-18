function coordinates_pack(argument0, argument1) {
	return (((argument0 + 0xEFFFFFFF) & 0x00000000FFFFFFFF) << 32) + ((argument1 + 0xEFFFFFFF) & 0x00000000FFFFFFFF)


}
