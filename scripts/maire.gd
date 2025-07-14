extends Sprite2D

var in_body : bool = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir") and in_body:
		GestionDialogue.lancer_timeline("maire_1")
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $"../steven":
		in_body = true
		$Polygon2D.visible = true
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == $"../steven":
		in_body = false
		$Polygon2D.visible = false
