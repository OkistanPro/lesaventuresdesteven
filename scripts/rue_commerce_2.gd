extends Node2D

func _ready() -> void:
	if Globals.machine_cafe_casse and Globals.machine_the_casse and $cyprien.visible:
		Musique.stream = Musique.musique_bataille
		Musique.play()
	else:
		Musique.interieur = false
	
	if Globals.direction_from == "rue_commerce_hotel":
		$steven.position = Vector2(31, Globals.y_from)
	if Globals.direction_from == "coffee":
		$steven.position = Vector2(245, 263)
	if Globals.direction_from == "tea":
		$steven.position = Vector2(411, 261)
	if Globals.direction_from == "rue_residence_parc2":
		$steven.position = Vector2(333, 665)
	GestionDialogue.event_declencheur.connect(changement_timeline)
	Globals.event_declencheur.connect(coffre_change_sprite)
	if GestionQuetes.liste_quetes["quete_clés_1.tres"].state == Quete.Quete_State.EN_COURS:
		if get_node_or_null("Cle4"):
			$Cle4.visible = true
			$Cle4.properties.pickable = true
		
		
func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_coffee", "rue_commerce_hotel", $steven.position.y, self)


func _on_goto_coffee_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_coffee", "coffee", $steven.position.y, self)


func _on_goto_tea_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_coffee", "tea", $steven.position.y, self)


func _on_bataille_cafe_the_body_entered(body: Node2D) -> void:
	if body == $steven and Globals.machine_cafe_casse and Globals.machine_the_casse:
		$AnimationPlayer.play("bataille_coffee_the")
		$cyprien/StaticBody2D.process_mode = Node.PROCESS_MODE_PAUSABLE
		$squeezie/StaticBody2D.process_mode = Node.PROCESS_MODE_PAUSABLE
		Globals.bataille = true

func stop_music() -> void:
	Musique.stop()
	GestionSons.play_sound("porte")
	Globals.dialogue_bataille_passed = true

func porte() -> void:
	GestionSons.play_sound("porte")

func timeline_bataille(nom_timeline : String) -> void:
	match nom_timeline:
		"bataille1":
			GestionDialogue.lancer_timeline("bataille_café_thé1")
		"bataille2":
			GestionDialogue.lancer_timeline("bataille_café_thé2")
		"bataille3":
			if GestionsEvents.current_event == "event_alter1":
				Musique.stream = Musique.musique_bataille_bug
			else:
				Musique.stream = Musique.musique_bataille
			Musique.play()
			GestionDialogue.lancer_timeline("bataille_café_thé3")

func changement_timeline(nom_event : String) -> void:
	if nom_event == "bataille_café_thé2":
		$AnimationPlayer.play("bataille_coffee_the_2")
	if nom_event == "bataille_café_thé3":
		$AnimationPlayer.play("bataille_coffee_the_3")
	if nom_event == "fin_bataille":
		$bataille_cafe_the.queue_free()
		$pnj1.nom_timeline = "regarde_bataille2"
		$pnj2.nom_timeline = "regarde_bataille3"
		$PNJ.nom_timeline = "regarde_bataille1"

func coffre_change_sprite(nom_event : String) -> void:
	if nom_event == "coffre":
		$Coffre.texture = load("res://sprites/COFFRE_OUVERT.png")
		$coffre_area/InteractionComponent.nom_timeline = ""


func _on_goto_parc_body_entered(body: Node2D) -> void:
		if body == $steven:
			Globals.goto_scene("rue_commerce_coffee", "rue_residence_parc2", $steven.position.y, self)
