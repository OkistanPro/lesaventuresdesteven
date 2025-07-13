extends Node

signal inventory_changed(added : ItemProperties)

var village_centre = preload("res://scenes/village_1.tscn")
var rue_commerce_epicerie = preload("res://scenes/rue_commerce_epicerie.tscn")
var rue_commerce_souvenirs = preload("res://scenes/rue_commerce_souvenirs.tscn")
var rue_commerce_coffee = preload("res://scenes/rue_commerce_coffee.tscn")
var rue_commerce_hotel = preload("res://scenes/rue_commerce_hotel.tscn")
var direction_from : String
var y_from : float

var fleche_input = preload("res://scenes/fleche_input.tscn")

var inventory : Array[ItemProperties]

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	# GestionDialogue.lancer_timeline("boulangere")

func goto_scene(from : String, to : String, y : float) -> void:
	direction_from = from
	y_from = y
	match from:
		"village_centre":
			match to:
				"rue_commerce_epicerie":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_epicerie)
				"rue_commerce_hotel":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_hotel)
		"rue_commerce_hotel":
			match to:
				"village_centre":
					get_tree().change_scene_to_packed.call_deferred(village_centre)
				"rue_commerce_coffee":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_coffee)
		"rue_commerce_epicerie":
			match to:
				"village_centre":
					get_tree().change_scene_to_packed.call_deferred(village_centre)
				"rue_commerce_souvenirs":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_souvenirs)
		"rue_commerce_coffee":
			match to:
				"rue_commerce_hotel":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_hotel)
		"rue_commerce_souvenirs":
			match to:
				"rue_commerce_epicerie":
					get_tree().change_scene_to_packed.call_deferred(rue_commerce_epicerie)

func item_event(name_event : StringName):
	match name_event:
		&"test":
			GestionDialogue.lancer_timeline("lourd")

func pick_item(item : ItemProperties):
	inventory.append(item)
	inventory_changed.emit(item)
