extends Node

var village_centre = preload("res://scenes/village_1.tscn")
var rue_commerce_gauche = preload("res://scenes/rue_commerce_1.tscn")
var rue_commerce_droite = preload("res://scenes/rue_commerce_2.tscn")
var direction_from : String

var inventory : Array[Item]

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	# GestionDialogue.lancer_timeline("boulangere")

func goto_scene(from : String, to : String) -> void:
	direction_from = from
	match from:
		"village_centre":
			match to:
				"rue_commerce_gauche":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_gauche)
				"rue_commerce_droite":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_droite)
		"rue_commerce_gauche":
			match to:
				"village_centre":
					get_tree().change_scene_to_packed.call_deferred(village_centre)
		"rue_commerce_droite":
			match to:
				"village_centre":
					get_tree().change_scene_to_packed.call_deferred(village_centre)
