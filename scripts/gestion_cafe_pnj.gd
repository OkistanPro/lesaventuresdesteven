extends Node

func _ready() -> void:
	if Globals.machine_the_casse:
		$"..".nom_timeline = "gerant_cafe_fin_quete"
	GestionDialogue.event_declencheur.connect(changement_timeline)

func changement_timeline(nom_event : String) -> void:
	if nom_event == "lancement_quete_cafe":
		$"..".nom_timeline = "gerant_cafe_wait_quete"
	if nom_event == "machine_cafe_casse":
		$"..".nom_timeline = "gerant_cafe_fin_quete"
