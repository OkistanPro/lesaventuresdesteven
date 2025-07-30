extends Node

func _ready() -> void:
	GestionDialogue.event_declencheur.connect(changement_timeline)

func changement_timeline(nom_event : String) -> void:
	if nom_event == "lancement_quete_the":
		$"..".nom_timeline = "gerant_the_wait_quete"
