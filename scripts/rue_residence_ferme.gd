extends Node2D

func _ready() -> void:
	if Globals.direction_from == "rue_residence_champ":
		$steven.position = Vector2(601, Globals.y_from)

func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_ferme", "rue_residence_champ", $steven.position.y)
