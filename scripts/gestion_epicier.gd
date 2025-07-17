extends Node

func _ready() -> void:
	GestionDialogue.event_declencheur.connect(changement_timeline)
	
func changement_timeline(nom_event : String) -> void:
	if nom_event == "lancement_quete_carotte":
		$"..".nom_timeline = "epicier_carotte_wait"
	if nom_event == "end_quete_carotte":
		$"..".nom_timeline = "epicier"
		$"..".nom_timeline_selon_select.erase("carotte")
