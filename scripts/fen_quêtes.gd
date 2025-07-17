extends Control

var q_instance = preload("res://scenes/quete_instance.tscn")
var img_quete_fini = preload("res://sprites/LETTRE FAIT.png")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel") and visible:
		interface.fen_quetes()


func _on_visibility_changed() -> void:
	if is_visible_in_tree():
		for child in $Panel/VBoxContainer.get_children():
			$Panel/VBoxContainer.remove_child(child)
			child.queue_free()
		for quete_string in GestionQuetes.liste_quetes:
			var quete = GestionQuetes.liste_quetes[quete_string]
			if quete.state != Quete.Quete_State.INACTIF:
				var new_quete = q_instance.instantiate()
				new_quete.get_node("NomQuete").text = quete.titre_quete
				new_quete.get_node("DescQuete").text = quete.desc_quete
				if quete.state == Quete.Quete_State.FINI:
					new_quete.get_node("lettre").texture = img_quete_fini
				$Panel/VBoxContainer.add_child(new_quete)
