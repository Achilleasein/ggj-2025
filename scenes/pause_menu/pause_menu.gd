extends Control



func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false # Remove the pause menu

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/first_level/first_level.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
