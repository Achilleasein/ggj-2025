extends Node2D
@export var enemy_scene: PackedScene
@export var spawn_distance : float = 350.0 #Distance from player to spawn
@export var spawn_interval : float = 2.0 #Time between enemy spawns

@onready var player = get_parent().get_node("Player")

func _ready():
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
		var spawn_side = randf() > 0.5 #True for right side, false for left
		var spawn_position = player.global_position
		if spawn_side:
			spawn_position.x += spawn_distance
		else:
			spawn_position.x -= spawn_distance
		var enemy = enemy_scene.instantiate()
		enemy.global_position = spawn_position
		if spawn_side:
			enemy.get_node("Sprite2D").flip_h = true
		get_parent().add_child(enemy)
