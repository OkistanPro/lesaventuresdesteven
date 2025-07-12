extends CharacterBody2D

const SPEED : int = 75.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	var mult = 1.0
	if Input.is_action_pressed("run"):
		mult = 1.8
		$sprite.speed_scale = 2.0
	
	if not GestionDialogue.active:
		velocity = direction.normalized() * SPEED * mult
	else:
		velocity = Vector2.ZERO
	
	if velocity != Vector2.ZERO:
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
	
	move_and_slide()
