extends CharacterBody2D

@export var speed : float = 75.0 
@export var fire_rate_range : Vector2 = Vector2(1.0, 3.0)
@export var random_movement_offset : float = 0.5
@export var bullet_scene_path : String = "res://scenes/enemy_scenes/enemy_bullet.tscn"
@export var base_damage: int = 1

@onready var player = get_parent().get_node("Player")

var bullet_scene: PackedScene
var can_shoot = true
var health = 5

func _ready():
	bullet_scene = preload("res://scenes/enemy_scenes/enemy_bullet.tscn")

func _physics_process(_delta: float):
	if get_parent().is_player_alive == true:
		move_towards_player_with_randomness()
		update_sprite_direction()
		if can_shoot:
			shoot_randomly()
	else:
		pass

func move_towards_player_with_randomness():
	var target_direction = (player.global_position - global_position).normalized()
	var random_offset = Vector2(randf() * random_movement_offset - random_movement_offset/2,randf() * random_movement_offset - random_movement_offset/2)
	target_direction += random_offset
	velocity = target_direction.normalized() * speed
	move_and_slide()

func update_sprite_direction():
	if player.global_position.x < global_position.x:
		get_node("Sprite2D").flip_h = true
	else:
		get_node("Sprite2D").flip_h = false


func shoot_randomly():
	can_shoot = false
	shoot()
	var random_time = randf_range(fire_rate_range.x,fire_rate_range.y)
	await get_tree().create_timer(random_time).timeout
	can_shoot= true

func shoot():
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	var direction_to_player = (player.global_position - global_position).normalized()
	bullet.rotation = direction_to_player.angle()
	bullet.direction = direction_to_player

func take_damage(damage):
	health = max(health - damage, 0)
	if health <= 0 :
		queue_free()
