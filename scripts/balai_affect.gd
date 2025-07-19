extends Node
class_name BalaiComponent

var in_area : bool = false

func _ready() -> void:
	$"../../steven".balai.connect(effacement)
	$"../Area2D".body_entered.connect(body_enter)
	$"../Area2D".body_exited.connect(body_exit)

func effacement() -> void:
	if in_area and $"..".modulate.a > 0.0:
		$"..".modulate.a -= 0.4
		if $"..".modulate.a <= 0.0:
			Globals.nombre_salete += 1
		
func body_enter(body : Node2D) -> void:
	if body == $"../../steven":
		in_area = true
		
func body_exit(body : Node2D) -> void:
	if body == $"../../steven":
		in_area = false
