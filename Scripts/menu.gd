extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("desvanecer_entrada")
	$AnimatedSprite2D.play("default")

func _process(delta):
	pass

	


func _on_play_pressed() -> void:
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout  # Espera 2 segundos

	if GameManager.firs_time:
		GameManager.firs_time = false
		get_tree().change_scene_to_file("res://Scenes/Levels/history.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Levels/lvl_1.tscn")


func _on_options_pressed() -> void:
	pass # Replace with function body.
