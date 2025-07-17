@tool
extends Sprite2D
class_name PNJ

@export var nom_timeline : String
@export var nom_timeline_selon_select : Dictionary[String, String]
var in_body : bool = false
var polygon = preload("res://scenes/fleche_input.tscn")

func _ready() -> void:
	if get_child_count() == 0:
		var collision = StaticBody2D.new()
		var detection = Area2D.new()
		var node_custom = Node.new()
		var polygon_instance = polygon.instantiate()
		
		var collision_shape = CollisionShape2D.new()
		var detection_shape = CollisionShape2D.new()

		add_child(collision, true)
		collision.owner = get_tree().edited_scene_root
		collision.add_child(collision_shape, true)
		collision_shape.owner = get_tree().edited_scene_root
		add_child(detection, true)
		detection.owner = get_tree().edited_scene_root
		detection.add_child(detection_shape, true)
		detection_shape.owner = get_tree().edited_scene_root

		
		polygon_instance.visible = false
		add_child(polygon_instance)
		polygon_instance.owner = get_tree().edited_scene_root
		node_custom.name = "gestion_pnj"
		add_child(node_custom)
		node_custom.owner = get_tree().edited_scene_root
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir") and in_body:
		if Globals.selected_item == -1:
			GestionDialogue.lancer_timeline(nom_timeline)
		elif Globals.selected_item_name in nom_timeline_selon_select:
			GestionDialogue.lancer_timeline(nom_timeline_selon_select[Globals.selected_item_name])
		else:
			GestionSons.play_sound("no_timeline")
			# truc sonore si jamais on a pas l'objet
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $"../steven":
		in_body = true
		$Polygon2D.visible = true
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == $"../steven":
		in_body = false
		$Polygon2D.visible = false
