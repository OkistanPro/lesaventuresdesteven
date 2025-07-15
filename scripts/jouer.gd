extends Button

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/rue_residence_ferme.tscn")
	Musique.stop()
	Musique.stream = Musique.musique_village
	interface.get_node("Inventaire").visible = true
	Globals.in_cinematique = false
	Musique.play()
