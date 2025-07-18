extends Node2D

func _ready() -> void:
	Musique.interieur = true
	if Globals.direction_from == "rue_residence_parc2":
		$steven.position = Vector2(410, 452)

func _on_goto_champ_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("maison3", "rue_residence_parc2", 0.0, self)
