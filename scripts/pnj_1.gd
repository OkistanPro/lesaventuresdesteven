extends Sprite2D
class_name PNJ

@export var nom_timeline : String
@export var nom_timeline_selon_select : Dictionary[String, String]
var in_body : bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir") and in_body:
		if Globals.selected_item == -1:
			GestionDialogue.lancer_timeline(nom_timeline)
		elif Globals.selected_item_name in nom_timeline_selon_select:
			GestionDialogue.lancer_timeline(nom_timeline_selon_select[Globals.selected_item_name])
		else:
			pass
			# truc sonore si jamais on a pas l'objet
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $"../steven":
		in_body = true
		$Polygon2D.visible = true
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == $"../steven":
		in_body = false
		$Polygon2D.visible = false
