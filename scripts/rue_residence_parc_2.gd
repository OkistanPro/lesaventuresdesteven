extends Node2D

func _ready() -> void:
	Musique.interieur = false
	if Globals.direction_from == "rue_residence_parc1":
		$steven.position = Vector2(30, Globals.y_from)
	if Globals.direction_from == "maison3":
		$steven.position = Vector2(107, 234)
	if Globals.direction_from == "maison6":
		$steven.position = Vector2(545, 234)
	if Globals.direction_from == "rue_commerce_coffee":
		$steven.position = Vector2(326, 4)
	GestionDialogue.event_declencheur.connect(ouvre_portail)
	if GestionsEvents.current_event == "event_alter1":
		$PNJ.nom_timeline = "pnj_fille3_alter1"

func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_parc2", "rue_residence_parc1", $steven.position.y, self)


func _on_goto_maison_3_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_parc2", "maison3", $steven.position.y, self)

func _on_goto_maison_6_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_parc2", "maison6", $steven.position.y, self)

func ouvre_portail(nom_event : String) -> void:
	if nom_event == "supprimer_fille":
		$PNJ.visible = false
		$PNJ.process_mode = Node.PROCESS_MODE_DISABLED
		await get_tree().create_timer(8.0).timeout
		GestionSons.play_sound("glitch_chuchotement")
	if nom_event == "ouvre_portail":
		GestionSons.play_sound("son_portail")
		$decor_habitation.texture = load("res://sprites/RPG_PARC_2_0001_Calque-2_ouvert.png")
		$decor_habitation/StaticBody2D_ferme.process_mode = Node.PROCESS_MODE_DISABLED
		$decor_habitation/StaticBody2D_ouvert.process_mode = Node.PROCESS_MODE_PAUSABLE
		$portail.queue_free()
	if nom_event == "lettre_espoir":
		$PNJ.nom_timeline = ""


func _on_goto_coffee_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_parc2", "rue_commerce_coffee", $steven.position.x, self)
