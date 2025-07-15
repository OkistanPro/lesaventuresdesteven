extends Node2D

func _ready() -> void:
	if Globals.direction_from == "rue_residence_parc1":
		$steven.position = Vector2(30, Globals.y_from)

func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_parc2", "rue_residence_parc1", $steven.position.y)
