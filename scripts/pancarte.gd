extends Sprite2D

var in_area : bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir") and in_area and interface.in_quetes:
		interface.fen_quetes()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $"../steven":
		$Polygon2D.visible = true
		in_area = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == $"../steven":
		$Polygon2D.visible = false
		in_area = false
