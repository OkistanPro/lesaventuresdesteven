extends Sprite2D
class_name ItemObject

var inside_item : bool = false
@export var properties : ItemProperties
@onready var fleche = Globals.fleche_input.instantiate()

func _ready() -> void:
	var area = Area2D.new()
	var collision = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 30.0
	
	add_child(area)
	area.add_child(collision)
	collision.shape = shape
	
	add_child(fleche)
	fleche.position = Vector2(0.0, get_rect().position.y - 10.0)
	fleche.visible = false
	
	area.body_entered.connect(player_inside)
	area.body_exited.connect(player_outside)

func player_inside(body : PhysicsBody2D):
	if body == $"../steven":
		inside_item = true
		fleche.visible = true

func player_outside(body : PhysicsBody2D):
	if body == $"../steven":
		inside_item = false
		fleche.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir"):
		if inside_item:
			if properties.pickable:
				Globals.pick_item(properties)
				GestionSons.play_sound("collect_item")
				queue_free()
			else:
				Globals.item_event(properties.event_on_not_pick)
		
