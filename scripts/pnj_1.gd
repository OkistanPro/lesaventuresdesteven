extends Sprite2D
class_name PNJ

@export var nom_timeline : String
var in_body : bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir") and in_body:
		GestionDialogue.lancer_timeline(nom_timeline)
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $"../steven":
		in_body = true
		$Polygon2D.visible = true
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == $"../steven":
		in_body = false
		$Polygon2D.visible = false
