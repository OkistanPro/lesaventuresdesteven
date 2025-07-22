extends Node2D

var quetes_finis : bool = true

func _ready() -> void:
	Musique.interieur = false
	if Globals.direction_from == "croisement_residence":
		$steven.position = Vector2(Globals.y_from, 650)
	if Globals.direction_from == "rue_commerce_epicerie":
		$steven.position = Vector2(31, Globals.y_from)
	if Globals.direction_from == "rue_commerce_hotel":
		$steven.position = Vector2(601, Globals.y_from)
	if Globals.direction_from == "mairie":
		$steven.position = Vector2(352, 222)

	if GestionQuetes.liste_quetes["quete_clés_1.tres"].state == Quete.Quete_State.EN_COURS:
		if get_node_or_null("Cle2"):
			$Cle2.visible = true
			$Cle2.properties.pickable = true
	
	for quete in GestionQuetes.liste_quetes.values():
		if quete.state != Quete.Quete_State.FINI and quete.titre_quete != "Recuperer 7 clés":
			quetes_finis = false
	
	if quetes_finis:
		$Maire.visible = false
		$Maire.process_mode = Node.PROCESS_MODE_DISABLED
		$mecsombre.process_mode = Node.PROCESS_MODE_PAUSABLE
		$mecsombre.visible = true

	GestionDialogue.event_declencheur.connect(event_timeline)

func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("village_centre", "rue_commerce_epicerie", $steven.position.y, self)


func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("village_centre", "rue_commerce_hotel", $steven.position.y, self)


func _on_goto_rue_bas_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("village_centre", "croisement_residence", $steven.position.x, self)


func _on_goto_mairie_body_entered(body: Node2D) -> void:
	if body == $steven:
		if quetes_finis:
			Globals.goto_scene("village_centre", "mairie", $steven.position.x, self)
		else:
			GestionDialogue.lancer_timeline("autorisation_mairie")

func event_timeline(nom_event : String) -> void:
	if nom_event == "camera_change_mairie":
		$Camera2D.make_current()
	if nom_event == "camera_revient_mairie":
		$steven/Camera2D.make_current()
	if nom_event == "reprendre_musique":
		$Cle2.visible = true
		$Cle2.properties.pickable = true
