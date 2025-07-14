extends Node

signal lancer_dialogue

var dialogue_scene : PackedScene = preload("res://scenes/dialogue.tscn")
var timeline_actuel : D_Timeline
var liste_timeline = {
	"statue_piedebiche" : preload("res://dialogues/statue_piedebiche.tres"),
	"boulangere" : preload("res://dialogues/boulangere.tres"),
	"maire_1" : preload("res://dialogues/maire_1.tres"),
	"pnj_homme" : preload("res://dialogues/pnj_homme.tres"),
	"lourd" : preload("res://dialogues/lourd.tres"),
	"vendeur_boutique" : preload("res://dialogues/vendeur_boutique.tres"),
	"pnj_femme1" : preload("res://dialogues/pnj_femme1.tres"),
	"pnj_femme_banane" : preload("res://dialogues/pnj_femme_banane.tres")
}
var active : bool = false

func lancer_timeline(nom_timeline : String) -> void:
	if not active:
		timeline_actuel = liste_timeline[nom_timeline]
		active = true
		lancer_dialogue.emit()
