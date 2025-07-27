extends Control

var texte_cinematique : Array[String] = [
	"Dans un village tyrannisé...",
	"...où les habitants sont exploités...",
	"...où règne la terreur et le massacre...",
	"...le sort du village dépendra d'un seul et unique...",
	"...poussin.",
	"Attends, poussin ?"
]

func _ready() -> void:
	Globals.machine_cafe_casse = false
	Globals.machine_the_casse = false
	Globals.nombre_colis = 0
	Globals.nombre_salete = 0
	Globals.inventory.clear()
	Globals.inventory_changed.emit(null)
	Globals.parle_au_fermier = false
	Globals.selected_item = -1
	Globals.selected_item_name = ""
	Globals.dialogue_bataille_passed = false
	
	if GestionsEvents.current_event == "event_alter2":
		Globals.village_centre.pack(preload("res://scenes_alter2/village_1.tscn").instantiate())
		Globals.rue_commerce_epicerie.pack(preload("res://scenes_alter2/rue_commerce_epicerie.tscn").instantiate())
		Globals.rue_commerce_souvenirs.pack(preload("res://scenes_alter2/rue_commerce_souvenirs.tscn").instantiate())
		Globals.rue_commerce_coffee.pack(preload("res://scenes_alter2/rue_commerce_coffee.tscn").instantiate())
		Globals.rue_commerce_hotel.pack(preload("res://scenes_alter2/rue_commerce_hotel.tscn").instantiate())

		Globals.croisement_residence.pack(preload("res://scenes_alter2/rue_croisement_residence.tscn").instantiate())
		Globals.rue_residence_champ.pack(preload("res://scenes_alter2/rue_residence_champs.tscn").instantiate())
		Globals.rue_residence_laparc1.pack(preload("res://scenes_alter2/rue_residence_parc1.tscn").instantiate())
		Globals.rue_residence_laparc2.pack(preload("res://scenes_alter2/rue_residence_parc2.tscn").instantiate())
		Globals.rue_residence_ferme.pack(preload("res://scenes_alter2/rue_residence_ferme.tscn").instantiate())

		Globals.poulailler.pack(preload("res://scenes_alter2/poulailler.tscn").instantiate())
		Globals.ferme.pack(preload("res://scenes_alter2/ferme.tscn").instantiate())
		Globals.maison1.pack(preload("res://scenes_alter2/maison1.tscn").instantiate())
		Globals.maison2.pack(preload("res://scenes_alter2/maison2.tscn").instantiate())
		Globals.maison3.pack(preload("res://scenes_alter2/maison3.tscn").instantiate())
		Globals.maison4.pack(preload("res://scenes_alter2/maison4.tscn").instantiate())
		Globals.maison5.pack(preload("res://scenes_alter2/maison5.tscn").instantiate())
		Globals.maison6.pack(preload("res://scenes_alter2/maison6.tscn").instantiate())
		Globals.epicerie.pack(preload("res://scenes_alter2/epicerie.tscn").instantiate())
		Globals.hotel.pack(preload("res://scenes_alter2/hotel.tscn").instantiate())
		Globals.coffee.pack(preload("res://scenes_alter2/coffee.tscn").instantiate())
		Globals.tea.pack(preload("res://scenes_alter2/tea.tscn").instantiate())
		Globals.mairie.pack(preload("res://scenes_alter2/mairie.tscn").instantiate())
	elif GestionsEvents.current_event == "event_alter1":
		Globals.village_centre.pack(preload("res://scenes_save/village_1.tscn").instantiate())
		Globals.rue_commerce_epicerie.pack(preload("res://scenes_save/rue_commerce_epicerie.tscn").instantiate())
		Globals.rue_commerce_souvenirs.pack(preload("res://scenes_save/rue_commerce_souvenirs.tscn").instantiate())
		Globals.rue_commerce_coffee.pack(preload("res://scenes_save/rue_commerce_coffee.tscn").instantiate())
		Globals.rue_commerce_hotel.pack(preload("res://scenes_save/rue_commerce_hotel.tscn").instantiate())

		Globals.croisement_residence.pack(preload("res://scenes_save/rue_croisement_residence.tscn").instantiate())
		Globals.rue_residence_champ.pack(preload("res://scenes_save/rue_residence_champs.tscn").instantiate())
		Globals.rue_residence_laparc1.pack(preload("res://scenes_save/rue_residence_parc1.tscn").instantiate())
		Globals.rue_residence_laparc2.pack(preload("res://scenes_save/rue_residence_parc2.tscn").instantiate())
		Globals.rue_residence_ferme.pack(preload("res://scenes_save/rue_residence_ferme.tscn").instantiate())

		Globals.poulailler.pack(preload("res://scenes_save/poulailler.tscn").instantiate())
		Globals.ferme.pack(preload("res://scenes_save/ferme.tscn").instantiate())
		Globals.maison1.pack(preload("res://scenes_save/maison1.tscn").instantiate())
		Globals.maison2.pack(preload("res://scenes_save/maison2.tscn").instantiate())
		Globals.maison3.pack(preload("res://scenes_save/maison3.tscn").instantiate())
		Globals.maison4.pack(preload("res://scenes_save/maison4.tscn").instantiate())
		Globals.maison5.pack(preload("res://scenes_save/maison5.tscn").instantiate())
		Globals.maison6.pack(preload("res://scenes_save/maison6.tscn").instantiate())
		Globals.epicerie.pack(preload("res://scenes_save/epicerie.tscn").instantiate())
		Globals.hotel.pack(preload("res://scenes_save/hotel.tscn").instantiate())
		Globals.coffee.pack(preload("res://scenes_save/coffee.tscn").instantiate())
		Globals.tea.pack(preload("res://scenes_save/tea.tscn").instantiate())
		Globals.mairie.pack(preload("res://scenes_save/mairie.tscn").instantiate())

	Globals.in_cinematique = true
	Globals.in_menu = false
	if GestionsEvents.current_event == "event_alter1":
		await get_tree().create_timer(3.0).timeout
		GestionSons.play_sound("glitch1")
		await get_tree().create_timer(0.4).timeout
		$error.visible = true
		await get_tree().create_timer(1.0).timeout
		$error.visible = false
	
	if GestionsEvents.current_event == "event_alter2":
		$AnimationPlayer.play("cinematique_debut_2")
		Musique.stream = Musique.musique_cinematique_bug
		Musique.play()
		$sharpen.visible = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	skip()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir"):
		skip()

func skip() -> void:
	Globals.in_cinematique = false
	Globals.in_menu = true
	Musique.stop()
	Musique.stream = Musique.musique_menu
	Musique.play()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
