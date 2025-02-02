extends Control

@onready var start_button = $MenuHolder/MenuItems/Start

func _ready() -> void:
	$MenuHolder/MenuItems/Start.grab_focus()


func _on_Start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/first_level/first_level.tscn")

func _on_Settings_pressed() -> void:
	var settings = load("res://assets/main_menu/characters.png").get_instance_id()
	get_tree().current_scene.add_child(settings)

func _on_Exit_pressed() -> void:
	get_tree().quit()
