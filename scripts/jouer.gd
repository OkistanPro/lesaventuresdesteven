extends Button

func _on_pressed() -> void:
	Musique.stop()
	Globals.in_menu = false
	get_tree().change_scene_to_file("res://scenes/reveil.tscn")
