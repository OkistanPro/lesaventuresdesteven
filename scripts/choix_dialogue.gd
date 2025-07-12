extends ItemList

signal changed_timeline

func _on_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		var goto = get_item_metadata(index).goto
		GestionDialogue.timeline_actuel = goto
		changed_timeline.emit()
		$"..".visible = false
