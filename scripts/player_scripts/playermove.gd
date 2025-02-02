extends CharacterBody2D

@export var speed: float = 200.0  # Movement speed
@export var fire_rate: float = 0.1 #Time between shots taken
@export var muzzle_distance: float = 65.0 #Distance of the muzzle (Marker2D from the player_
#reference to the bullet scene
var bullet = preload("res://scenes/bubble_main/bullet.tscn")
var can_shoot = true
var health = 3

func _physics_process(_delta: float):
	# Movement input
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_shoot"):
		if can_shoot:
			shoot()
	# Normalize input to avoid faster diagonal movement
	input_vector = input_vector.normalized()

	# Apply movement
	velocity = input_vector * speed
	move_and_slide()
	update_muzzle_rotation()

func update_muzzle_rotation():
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	$Marker2D.global_position = global_position + direction * muzzle_distance
	$Marker2D.rotation = direction.angle()


func shoot():
		var b = bullet.instantiate()
		get_parent().add_child(b)
		b.global_position = $Marker2D.global_position
		b.direction = ($Marker2D.global_position - global_position).normalized()  # Pass direction to bullet
		b.rotation = $Marker2D.rotation
		can_shoot= false
		await get_tree().create_timer(fire_rate).timeout
		can_shoot= true

func take_damage():
	health -=1 
	if health == 0:
		get_parent().is_player_alive = false
		get_parent().pause_menu.visible = true
		get_parent().remove_child(self)
		queue_free()

func _on_area_2d_body_entered(body: CharacterBody2D):
	if body.is_in_group("Enemy"):
		take_damage()
