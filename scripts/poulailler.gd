extends Node2D

func _ready() -> void:
	Musique.interieur = true
	if Globals.direction_from == "rue_residence_ferme":
		$steven.position = Vector2(316, 565)


func _on_goto_exterieur_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("poulailler", "rue_residence_ferme", $steven.position.y, self)
