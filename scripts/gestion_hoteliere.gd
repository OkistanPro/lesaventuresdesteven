extends Node

func _ready() -> void:
	GestionDialogue.event_declencheur.connect(changement_timeline)
	Globals.event_declencheur.connect(changement_timeline)
	
func changement_timeline(nom_event : String):
	if nom_event == "lancement_quete_hotel":
		$"..".nom_timeline = "hoteliere_wait_menage"
	if nom_event == "fin_menage":
		$"..".nom_timeline = "hoteliere_menage_fin"
