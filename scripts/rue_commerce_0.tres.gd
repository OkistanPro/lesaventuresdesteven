extends Node2D

func _ready() -> void:
	Musique.interieur = false
	if Globals.direction_from == "epicerie":
		$steven.position = Vector2(333, 234)
	if GestionQuetes.liste_quetes["quete_relique_1.tres"].state == Quete.Quete_State.FINI and \
	GestionQuetes.liste_quetes["quete_carotte_1.tres"].state == Quete.Quete_State.FINI:
		if get_node_or_null("Colis1"):
			$Colis1.visible = true
			$Colis1/StaticBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
		if get_node_or_null("Colis2"):
			$Colis2.visible = true
			$Colis2/StaticBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
		if get_node_or_null("Colis3"):
			$Colis3.visible = true
			$Colis3/StaticBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
	if Globals.direction_from == "village_centre":
		$steven.position = Vector2(601, Globals.y_from)
	if Globals.direction_from == "rue_commerce_souvenirs":
		$steven.position = Vector2(31, Globals.y_from)
	if Globals.nombre_colis == 3 and GestionQuetes.liste_quetes["quete_colis_1.tres"].state == Quete.Quete_State.EN_COURS:
		$Epicerie.nom_timeline = "epicier_colis_finis"
	if GestionQuetes.liste_quetes["quete_relique_1.tres"].state == Quete.Quete_State.FINI:
		if get_node_or_null("Colis1"):
			$Colis1.properties.pickable = true
		if get_node_or_null("Colis2"):
			$Colis2.properties.pickable = true
		if get_node_or_null("Colis3"):
			$Colis3.properties.pickable = true


func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		if GestionQuetes.liste_quetes["quete_relique_1.tres"].state == Quete.Quete_State.FINI and \
		GestionQuetes.liste_quetes["quete_carotte_1.tres"].state == Quete.Quete_State.FINI:
			if get_node_or_null("Colis1"):
				$Colis1.visible = true
				$Colis1/StaticBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
			if get_node_or_null("Colis2"):
				$Colis2.visible = true
				$Colis2/StaticBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
			if get_node_or_null("Colis3"):
				$Colis3.visible = true
				$Colis3/StaticBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
		Globals.goto_scene("rue_commerce_epicerie", "village_centre", $steven.position.y, self)


func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		if GestionQuetes.liste_quetes["quete_relique_1.tres"].state == Quete.Quete_State.FINI and \
		GestionQuetes.liste_quetes["quete_carotte_1.tres"].state == Quete.Quete_State.FINI:
			if get_node_or_null("Colis1"):
				$Colis1.visible = true
				$Colis1/StaticBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
			if get_node_or_null("Colis2"):
				$Colis2.visible = true
				$Colis2/StaticBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
			if get_node_or_null("Colis3"):
				$Colis3.visible = true
				$Colis3/StaticBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
		Globals.goto_scene("rue_commerce_epicerie", "rue_commerce_souvenirs", $steven.position.y, self)
		


func _on_goto_epicerie_body_entered(body: Node2D) -> void:
	if body == $steven:
		if GestionQuetes.liste_quetes["quete_relique_1.tres"].state == Quete.Quete_State.FINI and \
			GestionQuetes.liste_quetes["quete_carotte_1.tres"].state == Quete.Quete_State.FINI:
			if get_node_or_null("Colis1"):
				$Colis1.visible = true
				$Colis1/StaticBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
			if get_node_or_null("Colis2"):
				$Colis2.visible = true
				$Colis2/StaticBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
			if get_node_or_null("Colis3"):
				$Colis3.visible = true
				$Colis3/StaticBody2D.process_mode = Node.PROCESS_MODE_ALWAYS
		Globals.goto_scene("rue_commerce_epicerie", "epicerie", $steven.position.y, self)
