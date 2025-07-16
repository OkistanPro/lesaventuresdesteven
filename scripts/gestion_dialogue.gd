extends Node

signal lancer_dialogue
signal fin_event
signal event_declencheur(nom_event : String)

var dialogue_scene : PackedScene = preload("res://scenes/dialogue.tscn")
var timeline_actuel : D_Timeline
var liste_timeline = {
	"statue_piedebiche" : preload("res://dialogues/statue_piedebiche.tres"),
	"epicier_carotte" : preload("res://dialogues/epicier_carotte.tres"),
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
	"pnj_fontaine" : preload("res://dialogues/pnj_fille1.tres"),
	"graines" : preload("res://dialogues/graines.tres"),
	"oeuf" : preload("res://dialogues/oeuf.tres")
}
var active : bool = false

func _ready() -> void :
	var directories_to_look_at = ["res://dialogues/"]
	while directories_to_look_at:
		var dir = DirAccess.open(directories_to_look_at[0])
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if dir.current_is_dir():
					print("Found directory: " + file_name)
					directories_to_look_at.append(directories_to_look_at[0] + file_name)
				else:
					print("Found file: " + file_name)
					liste_timeline[file_name.get_slice(".", 0)] = load(directories_to_look_at[0] + "/" + file_name)
				file_name = dir.get_next()
		else:
			print(directories_to_look_at[0])
			print("An error occurred when trying to access the path.")
		directories_to_look_at.pop_front()

func lancer_timeline(nom_timeline : String) -> void:
	if not active:
		timeline_actuel = liste_timeline[nom_timeline]
		active = true
		lancer_dialogue.emit()


func lancer_event(nom_event : String) -> void:
	match nom_event:
		"graine_regardé":
			Globals.graine_regarde = true
		"lancement_quete_carotte":
			GestionQuetes.lancer_quete("quete_carotte_1.tres")
		"degourdir_jambe":
			event_declencheur.emit("degourdir_jambe")
			Globals.parle_au_fermier = true
		"quitter_jeu":
			get_tree().quit()
