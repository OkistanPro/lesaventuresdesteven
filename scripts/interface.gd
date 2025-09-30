extends CanvasLayer

var in_quetes : bool = false
var anim_quete_scene = preload("res://scenes/animation_quete.tscn")
var cles : Array[String] = [
	&"clé n°1",
	&"clé n°2",
	&"clé n°3",
	&"clé n°4",
	&"clé n°5",
	&"clé n°6",
	&"clé n°7"
]

var count_cle = 0

var code = [0, 0, 0]

var cle = preload("res://items/cle7.tres")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	GestionDialogue.lancer_dialogue.connect(lancer_dialogue)

func lancer_dialogue() -> void:
	add_child(GestionDialogue.dialogue_scene.instantiate())

func _process(_delta: float) -> void:
	$coffre/TextureRect/violet_c.text = str(code[0])
	$coffre/TextureRect/rouge_c.text = str(code[1])
	$coffre/TextureRect/jaune_c.text = str(code[2])
	if GestionDialogue.active:
		$glitch2.visible = false
		$glitch2/AudioStreamPlayer.volume_linear = 0.0
	else:
		$glitch2/AudioStreamPlayer.volume_linear = 1.0

func fen_quetes() -> void:
	if not in_quetes:
		$"Quêtes".visible = true
		in_quetes = true
	else:
		$"Quêtes".visible = false
		in_quetes = false

func start_quete(nom_quete : String) -> void:
	var new_anim_quete_instance = anim_quete_scene.instantiate()
	new_anim_quete_instance.get_node("HFlowContainer/nom_quete").text = nom_quete
	add_child(new_anim_quete_instance)
	new_anim_quete_instance.get_node("AnimationPlayer").play("new_quete")

func end_quete(nom_quete : String) -> void:
	var new_anim_quete_instance = anim_quete_scene.instantiate()
	new_anim_quete_instance.get_node("HFlowContainer/nom_quete").text = nom_quete
	add_child(new_anim_quete_instance)
	new_anim_quete_instance.get_node("AnimationPlayer").play("fin_quete")

func verif_trappe() -> void:
	count_cle = 0
	for nom in cles:
		for item in Globals.inventory:
			if item.item_name == nom:
				count_cle += 1
	
	if count_cle >= 7:
		GestionDialogue.lancer_timeline("fin_cles")
	else:
		GestionDialogue.lancer_timeline("pas_assez_cles")


func _on_violet_bas_pressed() -> void:
	if code[0] == 9:
		code[0] = 0
	else:
		code[0] += 1


func _on_rouge_bas_pressed() -> void:
	if code[1] == 9:
		code[1] = 0
	else:
		code[1] += 1


func _on_jaune_bas_pressed() -> void:
	if code[2] == 9:
		code[2] = 0
	else:
		code[2] += 1


func _on_btn_envoie_pressed() -> void:
	if code[0] == 2 and code[1] == 6 and code[2] == 4:
		GestionSons.play_sound("door_lock_open")
		Globals.pick_item(cle)
		$coffre.visible = false
		Globals.event_declencheur.emit("coffre")
	else:
		GestionSons.play_sound("no_timeline")
		$coffre.visible = false
		code = [0, 0, 0]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir") and Globals.selected_item != -1 and Globals.selected_item_name == &"██████████████":
		if not $glitch2.visible:
			$glitch2.visible = true
			$glitch2/AudioStreamPlayer.play()
		else:
			$glitch2.visible = false
	if event.is_action_pressed("pause") and not Globals.in_cinematique and not Globals.in_menu:
		if not get_tree().paused:
			if not $"Quêtes".visible and not (get_node_or_null("glitch0") and $glitch0.visible) and not $glitch1.visible and not $glitch2.visible and not $MecChelouGrand.visible and not GestionDialogue.active:
				get_tree().paused = true
				$pause.visible = true
				AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		else:
			get_tree().paused = false
			$pause.visible = false
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
func _on_glitch_2_visibility_changed() -> void:
	if not $glitch2.visible:
		$glitch2/AudioStreamPlayer.stop()
