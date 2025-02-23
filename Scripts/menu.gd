extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

		
	$AnimationPlayer.play("desvanecer_entrada")
	$AnimatedSprite2D.play("default")
	if GameManager.en_español:
		$Play.text = "Jugar"
		$Options.text = "Opciones"
	else:
		$Play.text = "Play"
		$Options.text = "Options"

func _process(delta):
	pass

	


func _on_play_pressed() -> void:
	$Click.play()
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 

	if GameManager.firs_time:
		GameManager.firs_time = false
		get_tree().change_scene_to_file("res://Scenes/Levels/history.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Levels/lvl_1.tscn")


func _on_options_pressed() -> void:
	$Click.play()
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/Levels/settings.tscn")
