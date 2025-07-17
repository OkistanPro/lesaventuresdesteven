extends Node

func _ready() -> void:
	GestionDialogue.event_declencheur.connect(to_bis)

func to_bis(nom_event : String) -> void:
	if nom_event == "vendeur_montre_bis":
		$"..".nom_timeline = "vendeur_montre_bis"
	if nom_event == "lancement_quete_montre":
		$"..".nom_timeline = "vendeur_wait_montre"
	if nom_event == "fin_quete_montre":
		$"..".nom_timeline = "vendeur_montre_random"
