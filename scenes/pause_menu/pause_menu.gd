extends Control

#func _ready():
	#$VBoxContainer/Resume.connect("pressed", self, "_on_Resume_pressed")
	#$VBoxContainer/Quit.connect("pressed", self, "_on_Quit_pressed")

func _on_resume_pressed() -> void:
	get_tree().paused = false
	queue_free()  # Remove the pause menu

func _on_restart_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
