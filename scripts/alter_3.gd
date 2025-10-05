extends Node2D

var noise = preload("res://map/noise_generation.tres")
var noise_red = preload("res://map/noise_red.tres")
var zone : Vector2i
var poussin_glitched = preload("res://scenes/pnj_poussin_glitched.tscn")
var max_value : Vector2i

func _ready() -> void:
	Musique.stop()
	Musique.stream = Musique.musique_alter3
	Musique.play()
	noise.seed = randi()
	noise_red.seed = randi()
	
	
	
	zone = Vector2i(floor($steven.position.x/416), floor($steven.position.y/320))
	print(zone)
	for x in range(zone.x*13-13, zone.x*13+26):
		for y in range(zone.y*10-10, zone.y*10+20):
			var value_noise = noise.get_noise_2d(x, y)
			if value_noise > noise.get_noise_2d(max_value.x, max_value.y):
				max_value = Vector2i(x*32, y*32)
			if value_noise > -0.1 or (x < 3 and x > -3 and y < 3 and y > -3):
				$TileMapLayer2.set_cell(Vector2i(x, y), 5, Vector2i(1, 0))
				if randi_range(0, 3000) == 9:
					var poussin_instance = poussin_glitched.instantiate()
					add_child(poussin_instance)
					poussin_instance.position = Vector2i(x*32, y*32)
					poussin_instance.z_index = 2
			else:
				if noise_red.get_noise_2d(x, y) > 0.0:
					$TileMapLayer2.set_cell(Vector2i(x, y), 5, Vector2i(2, 0))
					$TileMapLayer2.set_cell(Vector2i(x, y-1), 5, Vector2i(2, 0))
					$TileMapLayer2.set_cell(Vector2i(x, y-2), 5, Vector2i(2, 0))
					$TileMapLayer2.set_cell(Vector2i(x, y-3), 5, Vector2i(0, 0))
				else:
					$TileMapLayer2.set_cell(Vector2i(x, y), 5, Vector2i(3, 0))
					$TileMapLayer2.set_cell(Vector2i(x, y-1), 5, Vector2i(3, 0))
					$TileMapLayer2.set_cell(Vector2i(x, y-2), 5, Vector2i(3, 0))
					$TileMapLayer2.set_cell(Vector2i(x, y-3), 5, Vector2i(4, 0))
	await get_tree().create_timer(40.0).timeout
	$AnimationPlayer.play("finjeu")
	

func _process(delta: float) -> void:
	if zone != Vector2i(floor($steven.position.x/416), floor($steven.position.y/320)):
		zone = Vector2i(floor($steven.position.x/416), floor($steven.position.y/320))
		generate_terrain()
		print(zone)
	

func generate_terrain() -> void:
	for x in range(zone.x*13-13, zone.x*13+26):
		for y in range(zone.y*10-10, zone.y*10+20):
			var value_noise = noise.get_noise_2d(x, y)
			if value_noise > noise.get_noise_2d(max_value.x, max_value.y):
				max_value = Vector2i(x*32, y*32)
			if value_noise > -0.1 or (x < 3 and x > -3 and y < 3 and y > -3):
				$TileMapLayer2.set_cell(Vector2i(x, y), 5, Vector2i(1, 0))
				if randi_range(0, 1700) == 9:
					var poussin_instance = poussin_glitched.instantiate()
					add_child(poussin_instance)
					poussin_instance.position = Vector2i(x*32, y*32)
					poussin_instance.z_index = 2
					poussin_instance.nom_timeline = "a"
			else:
				if noise_red.get_noise_2d(x, y) > 0.15:
					$TileMapLayer2.set_cell(Vector2i(x, y), 5, Vector2i(2, 0))
					$TileMapLayer2.set_cell(Vector2i(x, y-1), 5, Vector2i(2, 0))
					$TileMapLayer2.set_cell(Vector2i(x, y-2), 5, Vector2i(2, 0))
					$TileMapLayer2.set_cell(Vector2i(x, y-3), 5, Vector2i(0, 0))
				else:
					$TileMapLayer2.set_cell(Vector2i(x, y), 5, Vector2i(3, 0))
					$TileMapLayer2.set_cell(Vector2i(x, y-1), 5, Vector2i(3, 0))
					$TileMapLayer2.set_cell(Vector2i(x, y-2), 5, Vector2i(3, 0))
					$TileMapLayer2.set_cell(Vector2i(x, y-3), 5, Vector2i(4, 0))

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		$fin/AnimationPlayer.play("fin")
		$CanvasLayer/Label.queue_free()

func _fin_jeu() -> void:
	get_tree().quit()
