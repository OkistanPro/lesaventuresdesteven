extends Node
class_name InteractionComponent

@onready var area = $".."
@onready var fleche = $"../Polygon2D"
@onready var steven = $"../../steven"

@export var nom_timeline : String
@export var nom_timeline_selon_select : Dictionary[String, String]

var in_area : bool = false

func _ready() -> void:
	area.body_entered.connect(_on_area_entered)
	area.body_exited.connect(_on_area_exited)

func _on_area_entered(body : Node2D) -> void:
	if body == steven:
		in_area = true
		fleche.visible = true
		
func _on_area_exited(body : Node2D) -> void:
	if body == steven:
		in_area = false
		fleche.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir") and in_area:
		if Globals.selected_item == -1 and nom_timeline:
			GestionDialogue.lancer_timeline(nom_timeline)
		elif Globals.selected_item_name in nom_timeline_selon_select:
			GestionDialogue.lancer_timeline(nom_timeline_selon_select[Globals.selected_item_name])
