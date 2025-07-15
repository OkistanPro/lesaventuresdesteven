extends Node

signal lancer_dialogue
signal fin_event
signal event_declencheur(nom_event : String)

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
	"pnj_femme_banane" : preload("res://dialogues/pnj_femme_banane.tres"),
	"fermier_quete1" : preload("res://dialogues/fermier_quete1.tres"),
	"fermier_attente_quete1" : preload("res://dialogues/fermier_attente_quete1.tres"),
	"carotte_sous_terre": preload("res://dialogues/carotte_sous_terre.tres"),
	"pasforet" : preload("res://dialogues/pasforet.tres"),
	"pnj_fontaine" : preload("res://dialogues/pnj_fille1.tres")
}
var active : bool = false

func lancer_timeline(nom_timeline : String) -> void:
	if not active:
		timeline_actuel = liste_timeline[nom_timeline]
		active = true
		lancer_dialogue.emit()


func lancer_event(nom_event : String) -> void:
	match nom_event:
		"degourdir_jambe":
			event_declencheur.emit("degourdir_jambe")
			Globals.parle_au_fermier = true
		"quitter_jeu":
			get_tree().quit()
