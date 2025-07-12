extends Control

signal begin_message(message : String)
signal clicked

func _ready() -> void:
	next_message()

func next_message() -> void:
	var obj_dialogue = GestionDialogue.timeline_actuel.get_message()
	
	if obj_dialogue is D_Message:
		if obj_dialogue.event_at_start:
			lancer_event(obj_dialogue.event_at_start)
		$boite_message/boite_perso/perso.text = obj_dialogue.nom_perso
		begin_message.emit(obj_dialogue.mess)
		await $boite_message/message.message_ended
		if obj_dialogue.liste_choix:
			$boite_message/boite_choix/ItemList.clear()
			for choix in obj_dialogue.liste_choix:
				var item_index = $boite_message/boite_choix/ItemList.add_item(choix.libelle_choix)
				$boite_message/boite_choix/ItemList.set_item_metadata(item_index, choix)
			$boite_message/boite_choix.visible = true
		else:
			await clicked
			next_message()
	elif obj_dialogue is D_Pause:
		$boite_message/message.text = ""
		if not obj_dialogue.affiche_dialogue:
			visible = false
		await get_tree().create_timer(obj_dialogue.temps).timeout
		visible = true
		next_message()
	elif obj_dialogue is D_Event:
		lancer_event(obj_dialogue.nom_event)
	else:
		GestionDialogue.active = false
		queue_free()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			clicked.emit()

func lancer_event(nom_event : String) -> void:
	match nom_event:
		"quitter_jeu":
			get_tree().quit()
