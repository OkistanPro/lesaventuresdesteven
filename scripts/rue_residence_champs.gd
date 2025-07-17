extends Node2D

func _ready() -> void:
	if get_node_or_null("ItemObject") != null and GestionQuetes.liste_quetes["quete_carotte_1.tres"].state == Quete.Quete_State.EN_COURS:
		$ItemObject.properties.pickable = true
	if Globals.direction_from == "rue_residence_ferme":
		$steven.position = Vector2(30, Globals.y_from)
	if Globals.direction_from == "croisement_residence":
		$steven.position = Vector2(601, Globals.y_from-80.0)

func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_champ", "rue_residence_ferme", $steven.position.y, self)


func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_champ", "croisement_residence", $steven.position.y, self)
