extends AudioStreamPlayer
var musique_interieur = preload("res://musique/OST_MAISON.wav")
var musique_interieur_bug = preload("res://musique/GLITCH/OST_MAISON_GLITCH1.wav")
var musique_village = preload("res://musique/OST_VILLAGEe.wav")
var musique_village_bug = preload("res://musique/GLITCH/OST_VILLAGE_GLITCH1.wav")
var musique_cinematique = preload("res://sons/OST_CINEMATIQUE.wav")
var musique_menu = preload("res://sons/OST_MENU.wav")
var musique_triste = preload("res://musique/OST_TRISTE_STEVEN.wav")
var musique_bataille = preload("res://sons/OST_COFFEE-THE.wav")
var musique_bataille_bug = preload("res://musique/GLITCH/OST_COFFEE-THE_GLITCH1.wav")
var musique_mairie = preload("res://sons/OST_MAIRIE.wav")
var musique_mairie_bug = preload("res://sons/OST_MAIRIE2.wav")
var musique_cinematique_bug = preload("res://musique/cinematique_bug.wav")
var musique_menu_bug = preload("res://musique/GLITCH/OST_MENU_GLITCH1.wav")
var musique_poussin_dead = preload("res://sons/dead_poussin.wav")
var musicbox = preload("res://sons/musicbox.wav")
var steven_pleure = preload("res://sons/steven_pleure.wav")
var musique_alter3 = preload("res://sons/OST bizzare.wav")

var interieur : bool = true:
	set(value):
		if value:
			if stream != musique_interieur and stream != musique_interieur_bug:
				if GestionsEvents.current_event == "event_alter2":
					stream = musique_interieur_bug
				else:
					stream = musique_interieur
				play()
		else:
			if stream != musique_village and stream != musique_village_bug:
				if GestionsEvents.current_event == "event_alter2":
					stream = musique_village_bug
				else:
					stream = musique_village
				play()
		interieur = value
		

func _ready() -> void:
	bus = &"Musique"
	process_mode = Node.PROCESS_MODE_ALWAYS
	if Globals.in_cinematique:
		if GestionsEvents.current_event == "event_alter2":
			stream = musique_cinematique_bug
		else:
			stream = musique_cinematique
	if Globals.in_menu:
		if GestionsEvents.current_event == "event_alter2":
			stream = musique_menu_bug
		else:
			stream = musique_menu
	if not Globals.in_cinematique and not Globals.in_menu:
		if GestionsEvents.current_event == "event_alter2":
			stream = musique_village_bug
		else:
			stream = musique_village
	
	if not Globals.in_reveil:
		play()
	
	if GestionsEvents.current_event == "event_alter2":
		glitched()

func glitched() -> void:
	while GestionsEvents.current_event == "event_alter2":
		if randi_range(0, 10) == 10:
			pitch_scale = randf_range(0.5, 1.0)
		else:
			pitch_scale = 1.0
		await get_tree().create_timer(5.0).timeout
