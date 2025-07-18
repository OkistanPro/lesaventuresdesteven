extends Node2D

func _ready() -> void:
	Musique.interieur = false
	if get_node_or_null("ItemObject") != null and GestionQuetes.liste_quetes["quete_carotte_1.tres"].state == Quete.Quete_State.EN_COURS:
		$ItemObject.properties.pickable = true
	if Globals.direction_from == "rue_residence_ferme":
		$steven.position = Vector2(30, Globals.y_from)
	if Globals.direction_from == "croisement_residence":
		$steven.position = Vector2(601, Globals.y_from-80.0)
	if Globals.direction_from == "maison1":
		$steven.position = Vector2(107, 234)
	if Globals.direction_from == "maison4":
		$steven.position = Vector2(545, 234)

func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_champ", "rue_residence_ferme", $steven.position.y, self)


func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_champ", "croisement_residence", $steven.position.y, self)


func _on_goto_maison_1_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_champ", "maison1", $steven.position.y, self)


func _on_goto_maison_4_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_champ", "maison4", $steven.position.y, self)
