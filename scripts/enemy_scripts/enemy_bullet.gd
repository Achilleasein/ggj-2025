extends Sprite2D

@export var bullet_speed: float = 750.0  # Speed of the bullet
@export var bullet_damage: int = 1

var direction: Vector2 = Vector2.ZERO

func _ready():
	direction = direction.normalized()

func _process(delta: float):
	position += direction * bullet_speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_body_entered(body):
	if body.name =='Player':
		set_process(false)
		body.take_damage(bullet_damage)
		await get_tree().create_timer(0.2).timeout
		queue_free()
