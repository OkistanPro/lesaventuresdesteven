extends Control

var paragraphes = [
	"[color=red]ERROR_0x442AA01[/color]\n\n",
	"Une erreur est survenue pendant l'exécution du programme.\n\n",
	"lesaventuresdesteven.exe\n",
	"Les Aventures De Steven\n",
	"REVISION 2\n\n\n",
	"0028:C0011E36 in VXD VMM(01) + 00010E36.\n",
	"at LINE 0xC0218C6A\n",
	"at LINE 0xC0218C6B\n",
	"at LINE 0xC0218C6F\n",
	"\n\nComme défini dans les procédures globales de l'application, le système va effectuer un redémarrage automatique.\n",
	"Appuyer sur Entrée pour continuer."
]

var restart : bool = false

func _ready() -> void:
	Musique.stop()
	GestionSons.playback.stop()
	GestionSons.playback.start()
	for line in paragraphes:
		$Label.append_text(line)
		await get_tree().create_timer(randf_range(0.01, 0.04)).timeout
	
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


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_ENTER and not restart:
		restart = true
		GestionsEvents.launch_count += 1
		$Label.append_text("\n\nSTART LESAVENTURESDESTEVEN.EXE -NO_SAFE")
		await get_tree().create_timer(1.8).timeout
		$ColorRect.visible = true
		await get_tree().create_timer(0.5).timeout
		for quete in GestionQuetes.liste_quetes:
			GestionQuetes.liste_quetes[quete].state = Quete.Quete_State.INACTIF
		Musique.stream = Musique.musique_cinematique
		Musique.play()
		get_tree().change_scene_to_file("res://scenes/cinematique.tscn")
