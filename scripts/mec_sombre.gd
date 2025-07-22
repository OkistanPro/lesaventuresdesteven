extends Node

func _ready() -> void:
	GestionDialogue.event_declencheur.connect(changement_timeline)
	
func changement_timeline(nom_event : String) -> void:
	if nom_event == "reprendre_musique":
		$"..".nom_timeline = "mec_sombre_wait"
