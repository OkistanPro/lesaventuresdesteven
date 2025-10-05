extends Node

signal lancer_dialogue
signal fin_event
signal event_declencheur(nom_event : String)
signal fin_discu

var dialogue_scene : PackedScene = preload("res://scenes/dialogue.tscn")
var timeline_actuel : D_Timeline
var liste_timeline = {
}
var active : bool = false:
	set(value):
		active = value
		if not active:
			fin_discu.emit()
var kayou = preload("res://items/kayou.tres")
var cle = preload("res://items/cle.tres")
var statue = preload("res://items/statue.tres")
var galerie_photo = preload("res://items/galerie_photo.tres")
var affiche = preload("res://items/affiche_aled.tres")

var glitched_dialogues = [
	preload("res://dialogues_glitched/pnj_glitched_1.tres"),
	preload("res://dialogues_glitched/pnj_glitched_2.tres"),
	preload("res://dialogues_glitched/pnj_glitched_3.tres"),
	preload("res://dialogues_glitched/pnj_glitched_4.tres"),
]

var poussin_dialogues = [
	preload("res://poussin_dialogue/poussin_1.tres"),
	preload("res://poussin_dialogue/poussin_2.tres"),
	preload("res://poussin_dialogue/poussin_3.tres"),
	preload("res://poussin_dialogue/poussin_4.tres"),
	preload("res://poussin_dialogue/poussin_5.tres"),
	preload("res://poussin_dialogue/poussin_6.tres"),
	preload("res://poussin_dialogue/poussin_7.tres"),
	preload("res://poussin_dialogue/poussin_8.tres"),
	preload("res://poussin_dialogue/poussin_9.tres"),
	preload("res://poussin_dialogue/poussin_10.tres"),
	preload("res://poussin_dialogue/poussin_11.tres"),
	preload("res://poussin_dialogue/poussin_12.tres"),
	preload("res://poussin_dialogue/poussin_13.tres")
]

var vhs_1_dialogue = preload("res://dialogues_glitched/lettre.tres")
var poussin_dead = preload("res://dialogues_glitched/poussin_dead.tres")
var rafod_tech_dialogue = preload("res://dialogues_glitched/rafod_tech.tres")
var rafod_tech_dialogue2 = preload("res://dialogues_glitched/rafod_tech2.tres")
var harcele = preload("res://dialogues_glitched/poussin_harcele.tres")
var steven_pleure = preload("res://dialogues_glitched/maire_pleure.tres")
var rafod_tech_dialogue3 = preload("res://dialogues_glitched/rafod_tech3.tres")
var pancarte_croisement_glitch = preload("res://dialogues/pancarte_croisement_glitch.tres")
var pancarte_village_glitch = preload("res://dialogues/pancarte_village_glitch.tres")

var pris_objet : bool = false
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
		if GestionsEvents.current_event == "event_alter2":
			match nom_timeline:
				"fermier_quete1":
					timeline_actuel = vhs_1_dialogue
					active = true
					lancer_dialogue.emit()
				"poussin5_dos":
					timeline_actuel = poussin_dead
					active = true
					lancer_dialogue.emit()
				"pnj_homme4":
					timeline_actuel = rafod_tech_dialogue
					active = true
					lancer_dialogue.emit()
				"pnj_homme2":
					timeline_actuel = rafod_tech_dialogue2
					active = true
					lancer_dialogue.emit()
				"pnj_fille2":
					timeline_actuel = harcele
					active = true
					lancer_dialogue.emit()
				"maire_1":
					timeline_actuel = steven_pleure
					active = true
					lancer_dialogue.emit()
				"epicier_carotte":
					timeline_actuel = rafod_tech_dialogue3
					active = true
					lancer_dialogue.emit()
				"pancarte_croisement_glitch":
					timeline_actuel = pancarte_croisement_glitch
					active = true
					lancer_dialogue.emit()
				"pancarte_village_glitch":
					timeline_actuel = pancarte_village_glitch
					active = true
					lancer_dialogue.emit()
				_:
					timeline_actuel = glitched_dialogues[randi_range(0, len(glitched_dialogues)-1)]
					active = true
					lancer_dialogue.emit()
		elif GestionsEvents.current_event == "event_alter3":
			timeline_actuel = poussin_dialogues[randi_range(0, len(poussin_dialogues)-1)]
			active = true
			lancer_dialogue.emit()
		else:
			timeline_actuel = liste_timeline[nom_timeline]
			active = true
			lancer_dialogue.emit()


func lancer_event(nom_event : String) -> void:
	match nom_event:
		"prendre_tourne_1":
			Globals.pick_item(galerie_photo)
			GestionSons.play_sound("collect_item")
			pris_objet = true
		"prendre_tourne_2":
			Globals.pick_item(statue)
			GestionSons.play_sound("collect_item")
			pris_objet = true
		"prendre_tourne_3":
			if GestionsEvents.current_event == "event_alter1":
				affiche.texture_icon = load("res://sprites/affiche_disparition.png")
			Globals.pick_item(affiche)
			GestionSons.play_sound("collect_item")
			pris_objet = true
		"test_tourne1":
			await fin_discu
			if GestionQuetes.liste_quetes["quete_relique_1.tres"].state == Quete.Quete_State.FINI and not pris_objet:
				GestionDialogue.lancer_timeline("tourne_1_true")
			else:
				GestionDialogue.lancer_timeline("tourne_false")
		"test_tourne2":
			await fin_discu
			if GestionQuetes.liste_quetes["quete_relique_1.tres"].state == Quete.Quete_State.FINI and not pris_objet:
				GestionDialogue.lancer_timeline("tourne_2_true")
			else:
				GestionDialogue.lancer_timeline("tourne_false")
		"test_tourne3":
			await fin_discu
			if GestionQuetes.liste_quetes["quete_relique_1.tres"].state == Quete.Quete_State.FINI and not pris_objet:
				GestionDialogue.lancer_timeline("tourne_3_true")
			else:
				GestionDialogue.lancer_timeline("tourne_false")
		"fin_alter2":
			get_tree().change_scene_to_file("res://scenes_alter2/fin_alter2.tscn")
		"steven_pleure":
			interface.get_node("maire").visible = true
			Musique.stream = Musique.steven_pleure
			Musique.play()
			AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), true)
		"steven_fin":
			interface.get_node("maire").visible = false
			Musique.stream = Musique.musique_village_bug
			Musique.play()
			AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), false)
			event_declencheur.emit("retourner_maire")
		"poussin_dead":
			Musique.stream = Musique.musique_poussin_dead
			Musique.play()
			interface.get_node("DeadPoussin").visible = true
			interface.get_node("DeadPoussin/AnimationPlayer").play("dead_poussin")
			await interface.get_node("DeadPoussin/AnimationPlayer").animation_finished
			interface.get_node("DeadPoussin").visible = false
			Musique.stream = Musique.musique_village_bug
			Musique.play()
		"lettre_adieu":
			Musique.stream = Musique.musicbox
			Musique.play()
			interface.get_node("lettre_adieu").visible = true
			await get_tree().create_timer(20.0).timeout
			interface.get_node("lettre_adieu").visible = false
			interface.get_node("vhs1").visible = true
			interface.get_node("vhs1").play()
			await interface.get_node("vhs1").finished
			interface.get_node("vhs1").visible = false
			event_declencheur.emit("lettre_adieu")
			Musique.stop()
		"supprimer_fille":
			event_declencheur.emit("supprimer_fille")
		"toc_toc":
			GestionSons.play_sound("toc_toc")
		"crash_system":
			interface.get_node("MecChelouGrand").visible = false
			Musique.stop()
			Globals.in_cinematique = true
			get_tree().change_scene_to_file("res://scenes/crash_system.tscn")
		"scream":
			GestionSons.play_sound("scream")
			interface.get_node("MecChelouGrand").visible = true
		"affiche_telephone":
			interface.get_node("glitch1").visible = true
			interface.get_node("glitch1/AnimationPlayer").play("phone_animation")
		"play_telephone":
			GestionSons.play_sound("telephone")
			await get_tree().create_timer(50.66).timeout
			interface.get_node("glitch1").visible = false
			event_declencheur.emit("supprimer_fille")
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
				if item.item_name == &"montre" or item.item_name ==  &"██████████████":
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
