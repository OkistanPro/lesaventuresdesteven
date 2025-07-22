extends AnimatedSprite2D

func _ready() -> void:
	GestionDialogue.event_declencheur.connect(ouvrir_fermer)
	
func ouvrir_fermer(nom_event : String) -> void:
	if nom_event == "ouvrir_ascenceur":
		if animation == "ferme":
			GestionSons.play_sound("ouverture_ascenceur")
			play("ouverture")
			await animation_finished
			play("ouvert")
			$StaticBody2D.process_mode = Node.PROCESS_MODE_DISABLED
			await get_tree().create_timer(6.0).timeout
			if not $"../../hall_entree".visible:
				await $"../../hall_entree".visibility_changed
				await get_tree().create_timer(3.0).timeout
			$StaticBody2D.process_mode = Node.PROCESS_MODE_PAUSABLE
			play("fermeture")
			await animation_finished
			play("ferme")
