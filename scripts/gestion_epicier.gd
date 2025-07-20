extends Node

func _ready() -> void:
	GestionDialogue.event_declencheur.connect(changement_timeline)
	if GestionQuetes.liste_quetes["quete_relique_1.tres"].state == Quete.Quete_State.FINI and \
	GestionQuetes.liste_quetes["quete_carotte_1.tres"].state == Quete.Quete_State.FINI:
		if GestionQuetes.liste_quetes["quete_colis_1.tres"].state == Quete.Quete_State.INACTIF:
			$"..".nom_timeline = "epicier_colis"
		elif Globals.nombre_colis == 3 and GestionQuetes.liste_quetes["quete_colis_1.tres"].state == Quete.Quete_State.EN_COURS:
			$"..".nom_timeline = "epicier_colis_finis"
	
func changement_timeline(nom_event : String) -> void:
	if nom_event == "lancement_quete_carotte":
		$"..".nom_timeline = "epicier_carotte_wait"
	if nom_event == "fin_quete_carotte" or nom_event == "fin_quete_colis":
		$"..".nom_timeline = "epicier"
		$"..".nom_timeline_selon_select.erase("carotte")
	if nom_event == "lancement_quete_colis":
		$"..".nom_timeline = "epicier_colis_wait"
