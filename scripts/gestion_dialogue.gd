extends Node

signal lancer_dialogue
signal fin_event
signal event_declencheur(nom_event : String)

var dialogue_scene : PackedScene = preload("res://scenes/dialogue.tscn")
var timeline_actuel : D_Timeline
var liste_timeline = {
}
var active : bool = false
var kayou = preload("res://items/kayou.tres")
var cle = preload("res://items/cle.tres")

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
		"bug_fin_jeu":
			GestionSons.play_sound("bug_fin")
			get_tree().paused = true
			Musique.stream = Musique.musique_mairie_bug
			Musique.play()
			await get_tree().create_timer(5.0).timeout
			get_tree().paused = false
			filter.get_node("bug").visible = true
			await get_tree().create_timer(2.0).timeout
			Musique.stop()
			Globals.in_cinematique = true
			filter.get_node("bug").visible = false
			interface.get_node("trappe").visible = false
			get_tree().change_scene_to_file("res://scenes/crash_system.tscn")
		"coffre_devine":
			interface.get_node("coffre").visible = true
		"cache_trappe":
			interface.get_node("trappe").visible = false
		"afficher_trappe":
			interface.get_node("trappe").visible = true
			interface.get_node("trappe/AnimationPlayer").play("entree")
		"camera_change_mairie":
			event_declencheur.emit("camera_change_mairie")
		"camera_revient_mairie":
			event_declencheur.emit("camera_revient_mairie")
		"reprendre_musique":
			Musique.stream = Musique.musique_village
			Musique.play()
			GestionQuetes.lancer_quete("quete_clés_1.tres")
			event_declencheur.emit("reprendre_musique")
			Globals.pick_item(cle)
		"stop_musique":
			Musique.stop()
		"ouvrir_ascenceur":
			event_declencheur.emit("ouvrir_ascenceur")
		"fin_bataille":
			Globals.bataille = false
			event_declencheur.emit("fin_bataille")
		"revenir_camera":
			event_declencheur.emit("revenir_camera")
		"bataille_café_thé3":
			event_declencheur.emit("bataille_café_thé3")
		"bataille_café_thé2":
			event_declencheur.emit("bataille_café_thé2")
		"machine_cafe_casse":
			if GestionQuetes.liste_quetes["quete_thé_1.tres"].state == Quete.Quete_State.EN_COURS:
				event_declencheur.emit("machine_cafe_casse")
				GestionQuetes.end_quete("quete_thé_1.tres")
		"lancement_quete_the":
			GestionQuetes.lancer_quete("quete_thé_1.tres")
			event_declencheur.emit("lancement_quete_the")
		"machine_the_casse":
			if GestionQuetes.liste_quetes["quete_café_1.tres"].state == Quete.Quete_State.EN_COURS:
				event_declencheur.emit("machine_the_casse")
				GestionQuetes.end_quete("quete_café_1.tres")
		"lancement_quete_cafe":
			GestionQuetes.lancer_quete("quete_café_1.tres")
			event_declencheur.emit("lancement_quete_cafe")
		"son_dingo":
			GestionSons.play_sound("son_dingo")
		"ouvre_portail":
			event_declencheur.emit("ouvre_portail")
			for item in Globals.inventory:
				if item.item_name == &"Clé du jardin":
					Globals.inventory.erase(item)
					break
			Globals.inventory_changed.emit(null)
		"fin_quete_menage":
			GestionQuetes.end_quete("quete_menage_1.tres")
			event_declencheur.emit("fin_quete_menage")
			for item in Globals.inventory:
				if item.item_name == &"balai":
					Globals.inventory.erase(item)
					break
			Globals.inventory_changed.emit(null)
			Globals.pick_item(kayou)
			GestionSons.play_sound("collect_item")
			kayou.picked = true
		"lancement_quete_hotel":
			GestionQuetes.lancer_quete("quete_menage_1.tres")
			event_declencheur.emit("lancement_quete_hotel")
		"musique_interieur":
			Musique.stream = Musique.musique_interieur
			Musique.play()
		"musique_triste":
			Musique.stream = Musique.musique_triste
			Musique.play()
		"changement_musique":
			Musique.stop()
		"fin_quetes_oeufs":
			GestionQuetes.end_quete("quete_oeufs_1.tres")
			event_declencheur.emit("fin_quetes_oeufs")
			for item in Globals.inventory:
				if item.item_name == &"oeufs":
					Globals.inventory.erase(item)
					break
			Globals.inventory_changed.emit(null)
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
			event_declencheur.emit("fin_quete_carotte")
			for item in Globals.inventory:
				if item.item_name == &"carotte":
					Globals.inventory.erase(item)
					break
			Globals.inventory_changed.emit(null)
			Globals.pick_item(kayou)
			GestionSons.play_sound("collect_item")
			kayou.picked = true
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
