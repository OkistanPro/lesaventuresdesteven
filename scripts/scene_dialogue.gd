extends Control

signal begin_message(message : String)
signal clicked

func _ready() -> void:
	next_message()

func next_message() -> void:
	var obj_dialogue = GestionDialogue.timeline_actuel.get_message()
	$boite_message/Polygon2D.visible = false
	if obj_dialogue is D_Message:
		if obj_dialogue.event_at_start:
			GestionDialogue.lancer_event(obj_dialogue.event_at_start)
		if obj_dialogue.nom_perso == "":
			$boite_message/boite_perso.visible = false
		else:
			$boite_message/boite_perso.visible = true
			$boite_message/boite_perso/perso.text = obj_dialogue.nom_perso
		begin_message.emit(obj_dialogue.mess)
		await $boite_message/message.message_ended
		if obj_dialogue.liste_choix:
			$boite_message/boite_choix/ItemList.clear()
			for choix in obj_dialogue.liste_choix:
				if not choix.variable_condition or (choix.variable_condition and verif_cond(choix.variable_condition)):
					var item_index = $boite_message/boite_choix/ItemList.add_item(choix.libelle_choix)
					$boite_message/boite_choix/ItemList.set_item_metadata(item_index, choix)
					$boite_message/boite_choix/ItemList.set_item_tooltip_enabled(item_index, false)
			$boite_message/boite_choix.visible = true
		else:
			$boite_message/Polygon2D.visible = true
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
		GestionDialogue.lancer_event(obj_dialogue.nom_event)
		if obj_dialogue.parallele:
			next_message()
		else:
			await GestionDialogue.fin_event
			next_message()
	else:
		GestionDialogue.active = false
		GestionDialogue.timeline_actuel.current_message = 0
		queue_free()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if $boite_message/message.is_writing:
				$boite_message/message.speed = 0.02
			clicked.emit()

func verif_cond(string_condition : String) -> bool:
	match string_condition:
		_:
			return true
