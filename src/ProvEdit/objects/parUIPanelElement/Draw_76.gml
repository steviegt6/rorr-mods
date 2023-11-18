if (parent == objToolPanel || parent == objToolPanel.id) {
	x = ui_right - objToolPanel.width + left
	y = ui_bottom - objToolPanel.height + top
} else {
	x = parent.x + left
	y = parent.y + top
}