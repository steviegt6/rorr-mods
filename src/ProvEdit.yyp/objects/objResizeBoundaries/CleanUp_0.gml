if (lv_left != left || lv_right != right || lv_top != top || lv_bottom != bottom)
	action_do(Actions.levelInfo, "bounds", left, right, top, bottom)
if (old_mode != -1)
	objMain.edit_mode = old_mode
