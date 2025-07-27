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
