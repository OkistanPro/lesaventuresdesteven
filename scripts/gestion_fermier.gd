extends Node

@onready var pnj = $".."

func _ready() -> void:
	GestionDialogue.event_declencheur.connect(on_event)
	
func on_event(nom_event : String):
	match nom_event:
		"degourdir_jambe":
			pnj.nom_timeline = "fermier_attente_quete1"
			var scene_save = PackedScene.new()
			scene_save.pack($"../..")
			Globals.rue_residence_ferme = scene_save
