/// @function check_version
/// @param main
/// @param major
/// @param minor
/// @param patch

if (argument0[0] > argument1)
	return true
else if (argument0[0] == argument1) {
	if (argument0[1] > argument2)
		return true
	else if (argument0[1] == argument2) {
		return argument0[2] >= argument3
	} else return false
} else return false