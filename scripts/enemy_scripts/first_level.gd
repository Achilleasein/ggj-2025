extends Node2D

@onready var player_scene = preload("res://scenes/bubble_main/Bubble.tscn")
@onready var pause_menu = $UI/PauseMenu

var is_player_alive: bool = true



func _ready() -> void:
	pause_menu.visible = false
	var player = player_scene.instantiate()
	add_child(player)
	player.global_position = Vector2.ZERO



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		pause_menu.visible = true
		get_tree().paused = true
