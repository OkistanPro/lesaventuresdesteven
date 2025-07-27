extends Node

@onready var pnj = $".."

func _ready() -> void:
	GestionDialogue.event_declencheur.connect(on_event)
	if GestionsEvents.current_event == "event_alter1":
		pnj.nom_timeline_selon_select["oeufs"] = "fermier_oeufs_donne_alter1"
	
func on_event(nom_event : String):
	match nom_event:
		"lettre_adieu":
			pnj.nom_timeline = "aaa"
		"degourdir_jambe":
			pnj.nom_timeline = "fermier_attente_quete1"
		"lancement_quetes_oeufs":
			pnj.nom_timeline = "fermier_wait_oeufs"
		"fin_quetes_oeufs":
			pnj.nom_timeline = "fermier_random"
