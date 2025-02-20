extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		$"Press Space to continue".visible = false
		$Play.visible = true
		$Options.visible = true
		if OS.has_feature("web"):
			$Exit.visible = false
		else:
			$Exit.visible = true


	


func _on_play_pressed() -> void:
	if GameManager.firs_time:
		GameManager.firs_time = false
		get_tree().change_scene_to_file("res://Scenes/Levels/history.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Levels/lvl_1.tscn")


func _on_exit_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	pass # Replace with function body.
