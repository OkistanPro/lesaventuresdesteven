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
