extends Node

signal lancer_dialogue
signal fin_event
signal event_declencheur(nom_event : String)

var dialogue_scene : PackedScene = preload("res://scenes/dialogue.tscn")
var timeline_actuel : D_Timeline
var liste_timeline = {
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
		"fin_quete_colis":
			GestionQuetes.end_quete("quete_colis_1.tres")
			event_declencheur.emit("fin_quete_colis")
		"take_colis_marc":
			for item in Globals.inventory:
				if item.item_name == &"Colis Pour Marc":
					Globals.inventory.erase(item)
					break
			Globals.inventory_changed.emit(null)
			Globals.nombre_colis += 1
		"lancement_quetes_oeufs":
			GestionQuetes.lancer_quete("quete_oeufs_1.tres")
			event_declencheur.emit("lancement_quetes_oeufs")
			for item in Globals.inventory:
				if item.item_name == &"Colis Pour Fermier":
					Globals.inventory.erase(item)
					break
			Globals.inventory_changed.emit(null)
			Globals.nombre_colis += 1
		"take_colis_carole":
			for item in Globals.inventory:
				if item.item_name == &"Colis Pour Carole":
					Globals.inventory.erase(item)
					break
			Globals.inventory_changed.emit(null)
			Globals.nombre_colis += 1
		"lancement_quete_colis":
			GestionQuetes.lancer_quete("quete_colis_1.tres")
			event_declencheur.emit("lancement_quete_colis")
		"fin_quete_montre":
			GestionQuetes.end_quete("quete_relique_1.tres")
			event_declencheur.emit("fin_quete_montre")
			for item in Globals.inventory:
				if item.item_name == &"montre":
					Globals.inventory.erase(item)
					break
			Globals.inventory_changed.emit(null)
		"lancement_quete_montre":
			GestionQuetes.lancer_quete("quete_relique_1.tres")
			event_declencheur.emit("lancement_quete_montre")
		"vendeur_montre_bis":
			event_declencheur.emit("vendeur_montre_bis")
		"fin_quete_carotte":
			GestionQuetes.end_quete("quete_carotte_1.tres")
			event_declencheur.emit("end_quete_carotte")
			for item in Globals.inventory:
				if item.item_name == &"carotte":
					Globals.inventory.erase(item)
					break
			Globals.inventory_changed.emit(null)
		"graine_regardé":
			Globals.graine_regarde = true
		"lancement_quete_carotte":
			GestionQuetes.lancer_quete("quete_carotte_1.tres")
			event_declencheur.emit("lancement_quete_carotte")
		"degourdir_jambe":
			event_declencheur.emit("degourdir_jambe")
			Globals.parle_au_fermier = true
		"quitter_jeu":
			get_tree().quit()
