extends Node

signal inventory_changed(added : ItemProperties)
signal event_declencheur(nom_event : String)

var village_centre = preload("res://scenes/village_1.tscn")

var rue_commerce_epicerie = preload("res://scenes/rue_commerce_epicerie.tscn")
var rue_commerce_souvenirs = preload("res://scenes/rue_commerce_souvenirs.tscn")
var rue_commerce_coffee = preload("res://scenes/rue_commerce_coffee.tscn")
var rue_commerce_hotel = preload("res://scenes/rue_commerce_hotel.tscn")

var croisement_residence = preload("res://scenes/rue_croisement_residence.tscn")
var rue_residence_champ = preload("res://scenes/rue_residence_champs.tscn")
var rue_residence_laparc1 = preload("res://scenes/rue_residence_parc1.tscn")
var rue_residence_laparc2 = preload("res://scenes/rue_residence_parc2.tscn")
var rue_residence_ferme = preload("res://scenes/rue_residence_ferme.tscn")

var poulailler = preload("res://scenes/poulailler.tscn")
var ferme = preload("res://scenes/ferme.tscn")
var maison1 = preload("res://scenes/maison1.tscn")
var maison2 = preload("res://scenes/maison2.tscn")
var maison3 = preload("res://scenes/maison3.tscn")
var maison4 = preload("res://scenes/maison4.tscn")
var maison5 = preload("res://scenes/maison5.tscn")
var maison6 = preload("res://scenes/maison6.tscn")
var epicerie = preload("res://scenes/epicerie.tscn")
var hotel = preload("res://scenes/hotel.tscn")

var direction_from : String
var y_from : float
var selected_item : int = -1
var selected_item_name : String

var parle_au_fermier : bool = false
var graine_regarde : bool = false
var in_cinematique : bool = false
var in_menu : bool = false
var fleche_input = preload("res://scenes/fleche_input.tscn")
var in_reveil : bool = false:
	set(value):
		if value:
			Musique.stop()
		in_reveil = value

var nombre_colis : int = 0
var nombre_salete : int = 0:
	set(value):
		nombre_salete = value
		if nombre_salete == 6:
			event_declencheur.emit("fin_menage")

var inventory : Array[ItemProperties]

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	await get_tree().create_timer(2.0).timeout
	# GestionDialogue.lancer_timeline("boulangere")

func goto_scene(from : String, to : String, y : float, p_scene : Node2D) -> void:
	direction_from = from
	y_from = y
	p_scene.get_node("steven").position = Vector2(2000, 2000)
	match from:
		"village_centre":
			village_centre.pack(p_scene)
			match to:
				"rue_commerce_epicerie":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_epicerie)
				"rue_commerce_hotel":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_hotel)
				"croisement_residence":
					get_tree().change_scene_to_packed.call_deferred(croisement_residence)
		"rue_commerce_hotel":
			rue_commerce_hotel.pack(p_scene)
			match to:
				"village_centre":
					get_tree().change_scene_to_packed.call_deferred(village_centre)
				"rue_commerce_coffee":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_coffee)
				"hotel":
					get_tree().change_scene_to_packed.call_deferred(hotel)
		"rue_commerce_epicerie":
			rue_commerce_epicerie.pack(p_scene)
			match to:
				"village_centre":
					get_tree().change_scene_to_packed.call_deferred(village_centre)
				"rue_commerce_souvenirs":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_souvenirs)
				"epicerie":
					get_tree().change_scene_to_packed.call_deferred(epicerie)
		"rue_commerce_coffee":
			rue_commerce_coffee.pack(p_scene)
			match to:
				"rue_commerce_hotel":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_hotel)
		"rue_commerce_souvenirs":
			rue_commerce_souvenirs.pack(p_scene)
			match to:
				"rue_commerce_epicerie":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_epicerie)
		
		"croisement_residence":
			croisement_residence.pack(p_scene)
			match to:
				"village_centre":
					get_tree().change_scene_to_packed.call_deferred(village_centre)
				"rue_residence_champ":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_champ)
				"rue_residence_parc1":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_laparc1)
		"rue_residence_champ":
			rue_residence_champ.pack(p_scene)
			match to:
				"croisement_residence":
					get_tree().change_scene_to_packed.call_deferred(croisement_residence)
				"rue_residence_ferme":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_ferme)
				"maison1":
					get_tree().change_scene_to_packed.call_deferred(maison1)
				"maison4":
					get_tree().change_scene_to_packed.call_deferred(maison4)
		"rue_residence_parc1":
			rue_residence_laparc1.pack(p_scene)
			match to:
				"croisement_residence":
					get_tree().change_scene_to_packed.call_deferred(croisement_residence)
				"rue_residence_parc2":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_laparc2)
				"maison2":
					get_tree().change_scene_to_packed.call_deferred(maison2)
				"maison5":
					get_tree().change_scene_to_packed.call_deferred(maison5)
		"rue_residence_parc2":
			rue_residence_laparc2.pack(p_scene)
			match to:
				"rue_residence_parc1":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_laparc1)
				"maison3":
					get_tree().change_scene_to_packed.call_deferred(maison3)
				"maison6":
					get_tree().change_scene_to_packed.call_deferred(maison6)
		"rue_residence_ferme":
			rue_residence_ferme.pack(p_scene)
			match to:
				"rue_residence_champ":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_champ)
				"poulailler":
					get_tree().change_scene_to_packed.call_deferred(poulailler)
				"ferme":
					get_tree().change_scene_to_packed.call_deferred(ferme)
		"poulailler":
			poulailler.pack(p_scene)
			match to:
				"rue_residence_ferme":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_ferme)
		"ferme":
			ferme.pack(p_scene)
			match to:
				"rue_residence_ferme":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_ferme)
				
		"maison1":
			maison1.pack(p_scene)
			match to:
				"rue_residence_champ":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_champ)
		"maison2":
			maison2.pack(p_scene)
			match to:
				"rue_residence_parc1":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_laparc1)
		"maison3":
			maison3.pack(p_scene)
			match to:
				"rue_residence_parc2":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_laparc2)
		"maison4":
			maison4.pack(p_scene)
			match to:
				"rue_residence_champ":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_champ)
					
		"maison5":
			maison5.pack(p_scene)
			match to:
				"rue_residence_parc1":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_laparc1)
		"maison6":
			maison6.pack(p_scene)
			match to:
				"rue_residence_parc2":
					get_tree().change_scene_to_packed.call_deferred(rue_residence_laparc2)
		"epicerie":
			epicerie.pack(p_scene)
			match to:
				"rue_commerce_epicerie":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_epicerie)
		"hotel":
			hotel.pack(p_scene)
			match to:
				"rue_commerce_hotel":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_hotel)




func item_event(name_event : StringName, send_object : ItemProperties = null):
	match name_event:
		&"montre":
			event_declencheur.emit("montre")
		&"trou_vide":
			GestionDialogue.lancer_timeline("trou_vide")
		&"test":
			GestionDialogue.lancer_timeline("lourd")
		&"carotte_sous_terre":
			GestionDialogue.lancer_timeline("carotte_sous_terre")

func pick_item(item : ItemProperties):
	inventory.append(item)
	inventory_changed.emit(item)
