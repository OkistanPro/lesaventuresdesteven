extends Node2D

func _ready() -> void:
	if Globals.direction_from == "rue_residence_ferme":
		$steven.position = Vector2(481, 481)



func _on_goto_poulailler_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("ferme", "rue_residence_ferme", $steven.position.x, self)
