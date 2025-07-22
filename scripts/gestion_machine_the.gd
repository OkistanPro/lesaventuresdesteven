extends Node

func _ready() -> void:
	GestionDialogue.event_declencheur.connect(casse_machine)
	
func casse_machine(nom_event : String) -> void:
	if nom_event == "machine_the_casse" and not Globals.machine_the_casse:
		$"..".texture = load("res://sprites/MACHINE_A_THE_CASSE.png")
		GestionSons.play_sound("casse")
		Globals.machine_the_casse = true
