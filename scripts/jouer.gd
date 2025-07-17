extends Button

func _on_pressed() -> void:
	Musique.stop()
	Musique.stream = Musique.musique_interieur
	interface.get_node("Inventaire").visible = true
	Globals.in_cinematique = false
	Musique.play()
	get_tree().change_scene_to_file("res://scenes/poulailler.tscn")
