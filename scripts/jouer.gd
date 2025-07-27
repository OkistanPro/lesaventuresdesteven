extends Button

func _on_pressed() -> void:
	if GestionsEvents.current_event == "event_alter2":
		Musique.stop()
		Globals.in_menu = false
		get_tree().change_scene_to_file("res://scenes/poulailler.tscn")

	else:
		Musique.stop()
		Globals.in_menu = false
		get_tree().change_scene_to_file("res://scenes/reveil.tscn")
