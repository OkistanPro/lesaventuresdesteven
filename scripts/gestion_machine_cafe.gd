extends Node

func _ready() -> void:
	GestionDialogue.event_declencheur.connect(casse_machine)
	
func casse_machine(nom_event : String) -> void:
	if nom_event == "machine_cafe_casse" and Globals.machine_the_casse and not Globals.machine_cafe_casse:
		$"..".texture = load("res://sprites/MACHINE_A_CAFE_CASSE.png")
		GestionSons.play_sound("casse")
		Globals.machine_cafe_casse = true
		GestionDialogue.lancer_timeline("gerant_cafe_fin_quete")
