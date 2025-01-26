extends CharacterBody2D

@export var speed : float = 100.0 
@export var fire_rate_range : Vector2 = Vector2(1.0, 3.0)
@export var random_movement_offset : float = 0.5
@export var bullet_scene_path : String = "res://Bubble_Main/enemy_bullet.tscn"

var player: Node2D
var bullet_scene: PackedScene
var can_shoot: bool = true
