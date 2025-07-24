extends CharacterBody2D

signal balai
signal hache

const SPEED : int = 100.0
var direction : Vector2 = Vector2(0.0, 0.0)
var in_flaque : bool = false
var direction_flaque : Vector2 = Vector2.ZERO
var flip : bool = false

func _ready() -> void:
	GestionDialogue.event_declencheur.connect(revenir_camera)

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	var mult = 1.0
	if Input.is_action_pressed("run"):
		mult = 1.8
		$sprite.speed_scale = 2.0
	
	if not GestionDialogue.active and \
	not interface.in_quetes and \
	not $AnimationPlayer.is_playing() and \
	not Globals.bataille and\
	not (interface.get_node_or_null("glitch0") and interface.get_node("glitch0").visible) and\
	not (interface.get_node_or_null("glitch1") and interface.get_node("glitch1").visible):
		velocity = direction.normalized() * SPEED * mult
	else:
		velocity = Vector2.ZERO
	
	if velocity != Vector2.ZERO:
		direction_flaque = velocity
		
		if direction.angle() < -(2.*PI/3.) or direction.angle() >= 2.*PI/3.:
			# Gauche
			$sprite.play("left")
			$hache.position = Vector2(-14, 8.5)
			$hache.flip_h = false
			$hache.offset.x = -12.365
			flip = false
		if direction.angle() < -(PI/3.) and direction.angle() >= -(2.*PI/3.):
			# Haut
			$sprite.play("up")
		if direction.angle() < PI/3. and direction.angle() >= -(PI/3.):
			# Droite
			$sprite.play("right")
			$hache.position = Vector2(14, 8.5)
			$hache.flip_h = true
			$hache.offset.x = 12.365
			flip = true
		if direction.angle() < 2.*PI/3. and direction.angle() >= PI/3.:
			# Bas
			$sprite.play("down")
	else:
		$sprite.play("idle")
	
	if in_flaque and velocity != Vector2.ZERO:
		velocity += direction_flaque * 0.7
	move_and_slide()


func _on_flaque_body_entered(body: Node2D) -> void:
	if body == self:
		in_flaque = true
		GestionSons.play_sound("flaque")


func _on_flaque_body_exited(body: Node2D) -> void:
	if body == self:
		in_flaque = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir") and \
	Globals.selected_item != -1:
		if Globals.selected_item_name == "balai" and not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("balai")
			GestionSons.play_sound("balai")
			balai.emit()
		if Globals.selected_item_name == "hache" and not $AnimationPlayer.is_playing():
			if flip:
				$AnimationPlayer.play("hache_back")
			else:
				$AnimationPlayer.play("hache")
			GestionSons.play_sound("hache")
			hache.emit()

func revenir_camera(nom_event : String) -> void:
	if nom_event == "revenir_camera":
		$Camera2D.make_current()
