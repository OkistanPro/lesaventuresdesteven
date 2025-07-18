extends Node2D

func _ready() -> void:
	Musique.interieur = true
	if Globals.direction_from == "rue_commerce_epicerie":
		$steven.position = Vector2(568, 427)
	GestionSons.play_sound("ding_epicerie")

func _on_goto_rue_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("epicerie", "rue_commerce_epicerie", 0.0, self)
