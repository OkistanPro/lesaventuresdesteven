extends Node2D

func _ready() -> void:
	Musique.interieur = true
	if Globals.direction_from == "rue_residence_champ":
		$steven.position = Vector2(390, 452)

func _on_goto_champ_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("maison4", "rue_residence_champ", 0.0, self)
