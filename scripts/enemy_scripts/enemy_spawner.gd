extends Node2D
@export var enemy_scene: PackedScene
@export var safe_radius : float = 350.0 #Distance from player to spawn
@export var spawn_interval : float = 2.0 #Time between enemy spawns


@onready var spawn_area = get_parent().get_node("SpawnArea/CollisionPolygon2D")

var player

func _ready():
	await get_parent().ready
	player = get_parent().get_node("Player")
	start_spawning()




func start_spawning():
	var spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.one_shot = false
	spawn_timer.autostart = true
	add_child(spawn_timer)
	spawn_timer.connect("timeout",Callable(self,"_spawn_enemy"))

func _spawn_enemy():
	randomize()
	if get_parent().is_player_alive == true:
		var spawn_position = get_valid_spawn_position()
		var spawn_side = spawn_position + player.global_position #True for right side, false for left
		var enemy = enemy_scene.instantiate()
		enemy.global_position = spawn_position
		if spawn_side.x > player.global_position.x:
			enemy.get_node("Sprite2D").flip_h = true
		get_parent().add_child(enemy)

func get_valid_spawn_position() -> Vector2:
	var shape = spawn_area.shape
	var area_position = spawn_area.global_position
	var spawn_position: Vector2

	while true:
		# Generate a random point within the collision shape's extents
		var random_x = randf_range(area_position.x - shape.extents.x, area_position.x + shape.extents.x)
		var random_y = randf_range(area_position.y - shape.extents.y, area_position.y + shape.extents.y)
		spawn_position = Vector2(random_x, random_y)

# Check if the position is too close to the player
		if spawn_position.distance_to(player.global_position) >= safe_radius:
			break  # If outside the safe zone, spawn here

# If the spawn was too close, move it exactly to spawn_distance away from the player
		if spawn_position.distance_to(player.global_position) < safe_radius:
			var direction = (spawn_position - player.global_position).normalized()
			spawn_position = player.global_position + direction * safe_radius

	return spawn_position
