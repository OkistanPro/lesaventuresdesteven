extends Node2D

func _ready() -> void:
	if Globals.direction_from == "village_centre":
		$steven.position = Vector2(601, 322)


func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_gauche", "village_centre")
