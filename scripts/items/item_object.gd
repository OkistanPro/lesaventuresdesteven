@tool
extends Sprite2D
class_name ItemObject

var inside_item : bool = false
@export var properties : ItemProperties
var fleche = preload("res://scenes/fleche_input.tscn").instantiate()

func _ready() -> void:
	if Engine.is_editor_hint():
		if get_child_count() == 0:
			var area = Area2D.new()
			var collision = CollisionShape2D.new()
			var shape = CircleShape2D.new()
			shape.radius = 30.0
			
			add_child(area, true)
			area.owner = get_tree().edited_scene_root
			area.add_child(collision)
			collision.owner = get_tree().edited_scene_root
			collision.shape = shape
			
			add_child(fleche, true)
			fleche.owner = get_tree().edited_scene_root
			fleche.position = Vector2(0.0, get_rect().position.y - 10.0)
			fleche.visible = false
	else:
		$Area2D.body_entered.connect(player_inside)
		$Area2D.body_exited.connect(player_outside)
		if properties.picked:
			queue_free()

func player_inside(body : PhysicsBody2D):
	if body == $"../steven":
		inside_item = true
		$Polygon2D.visible = true

func player_outside(body : PhysicsBody2D):
	if body == $"../steven":
		inside_item = false
		$Polygon2D.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir"):
		if inside_item and not interface.get_node("Inventaire/AnimationPlayer").is_playing():
			if properties.pickable and not properties.picked:
				Globals.pick_item(properties)
				GestionSons.play_sound("collect_item")
				properties.picked = true
				queue_free()
			else:
				Globals.item_event(properties.event_on_not_pick, properties)
		
