extends Node2D

func _ready() -> void:
	if Globals.direction_from == "village_centre":
		$steven.position = Vector2(Globals.y_from, 30)
	if Globals.direction_from == "rue_residence_champ":
		$steven.position = Vector2(30, Globals.y_from + 80)
	if Globals.direction_from == "rue_residence_parc1":
		$steven.position = Vector2(601, Globals.y_from + 80)

func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("croisement_residence", "rue_residence_champ", $steven.position.y - 40)


func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("croisement_residence", "rue_residence_parc1", $steven.position.y - 150)


func _on_goto_rue_bas_body_entered(body: Node2D) -> void:
	if body == $steven:
		GestionDialogue.lancer_timeline("pasforet")


func _on_goto_rue_haut_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("croisement_residence", "village_centre", $steven.position.x)
