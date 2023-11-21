x = ui_right - left
if (!bottom) {
	y = ui_top + top + top_offset
} else {
	if (objToolPanel.height > 0) {
		y = ui_bottom - objToolPanel.height - 35 - 28
	} else {
		y = ui_bottom - 40
	}
}