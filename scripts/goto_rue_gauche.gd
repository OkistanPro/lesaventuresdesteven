extends Area2D

func _process(delta: float) -> void:
	print(get_overlapping_bodies())
