extends CharacterBody2D

const SPEED : int = 75.0
var direction
var in_flaque : bool = false
var direction_flaque : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	var mult = 1.0
	if Input.is_action_pressed("run"):
		mult = 1.8
		$sprite.speed_scale = 2.0
	
	if not GestionDialogue.active and not interface.in_quetes:
		velocity = direction.normalized() * SPEED * mult
	else:
		velocity = Vector2.ZERO
	
	if velocity != Vector2.ZERO:
		direction_flaque = velocity
		match direction.normalized():
			# Bas
			Vector2(0.0, 1.0):
				$sprite.play("down")
			# Haut
			Vector2(0.0, -1.0):
				$sprite.play("up")
			# Gauche
			Vector2(-1.0, 0.0):
				$sprite.play("left")
			# Droite
			Vector2(1.0, 0.0):
				$sprite.play("right")
	else:
		$sprite.play("idle")
	
	if in_flaque and velocity != Vector2.ZERO:
		velocity += direction_flaque * 0.7
	move_and_slide()


func _on_flaque_body_entered(body: Node2D) -> void:
	if body == self:
		in_flaque = true


func _on_flaque_body_exited(body: Node2D) -> void:
	if body == self:
		in_flaque = false
