extends Node2D

func _ready() -> void:
	Musique.interieur = false
	if Globals.direction_from == "rue_residence_parc1":
		$steven.position = Vector2(30, Globals.y_from)
	if Globals.direction_from == "maison3":
		$steven.position = Vector2(107, 234)
	if Globals.direction_from == "maison6":
		$steven.position = Vector2(545, 234)

func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_parc2", "rue_residence_parc1", $steven.position.y, self)


func _on_goto_maison_3_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_parc2", "maison3", $steven.position.y, self)

func _on_goto_maison_6_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_parc2", "maison6", $steven.position.y, self)
