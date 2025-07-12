extends Node

var dialogue_scene : PackedScene = preload("res://scenes/dialogue.tscn")
var timeline_actuel : D_Timeline
var liste_timeline = {
	"statue_piedebiche" : preload("res://dialogues/statue_piedebiche.tres")
}
var active : bool = false

func lancer_timeline(nom_timeline : String) -> void:
	timeline_actuel = liste_timeline[nom_timeline]
	var dialogue_instance = dialogue_scene.instantiate()
	get_tree().current_scene.get_node("interface").add_child(dialogue_instance)
	active = true
