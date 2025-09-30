extends Control

# On définit "le joueur doit entrer quelque chose" par la possibilité d'éditer LineEdit

var output_text : String = "":
	set(value):
		output_text = value
		$stdout.clear()
		if $LineEdit.is_editing():
			$stdout.append_text(output_text + input_text + "_")
		else:
			$stdout.append_text(output_text + input_text)
		
var input_text : String = "":
	set(value):
		input_text = value
		$stdout.clear()
		if $LineEdit.is_editing():
			$stdout.append_text(output_text + input_text + "_")
		else:
			$stdout.append_text(output_text + input_text)

func _ready() -> void:
	Musique.stop()
	# Attendre 2 secondes
	await get_tree().create_timer(2.0).timeout
	# Afficher le message de bienvenue
	output_text += "RafodOS. version 0.1.0\n\n> "
	# On attend le joueur
	$LineEdit.edit()

func _on_line_edit_text_changed(new_text: String) -> void:
	input_text += new_text
	$LineEdit.text = ""

func _on_line_edit_text_submitted(new_text: String) -> void:
	output_text += input_text + "\n"
	var tmp_input_text = input_text
	input_text = ""
	
	$LineEdit.text = ""
	$LineEdit.unedit()
	
	_command(tmp_input_text)

func _on_line_backspace() -> void:
	input_text = input_text.left(len(input_text) - 1)
	$LineEdit.text = ""
	
func _command(command : String) -> void:
	# Gestion de la commande
	match command.left(4):
		"help":
			output_text += "Liste des commandes disponibles :\n"
			output_text += "help : affiche cette liste\n"
			output_text += "list : affiche les programmes qui peuvent être exécutés\n"
			output_text += "exec <nom_programme> : lance le programme\n"
			output_text += "exit : mise sous tension de la console\n"
		"list":
			output_text += "Liste des programmes disponibles :\n"
			output_text += "LESAVENTURESDESTEVEN\n"
		"exec":
			if command == "exec LESAVENTURESDESTEVEN":
				output_text += "Lancement de LESAVENTURESDESTEVEN."
				await get_tree().create_timer(2.0).timeout
				output_text += "."
				await get_tree().create_timer(2.0).timeout
				output_text += "."
				await get_tree().create_timer(2.0).timeout
				match GestionsEvents.current_event:
					"normal", "event_alter1":
						Musique.stream = Musique.musique_cinematique
						Musique.play()
					"event_alter2":
						Musique.stream = Musique.musique_cinematique_bug
						Musique.play()
				get_tree().change_scene_to_file.call_deferred("res://scenes/cinematique.tscn")
		_:
			output_text += "[color=red]ERR - Commande introuvable\nTaper \"help\" pour la liste des commandes disponibles.[/color]"
	# On ajoute la flèche en bas
	output_text += "\n> "
	# On attend le joueur
	$LineEdit.edit()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_BACKSPACE and $LineEdit.is_editing():
		_on_line_backspace()
