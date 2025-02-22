extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("desvanecer_entrada")
	
	if 	GameManager.en_español:
		$Texto.text = "¡Lo has
					Caracoleado!"
		
	else:
		$Texto.text = "You 
		'S'NAILED 
		IT!"
		$S.visible = true
		$S3.visible = true
		$S2.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	if GameManager.current_level == "res://Scenes/Levels/Level1.tscn":
		get_tree().change_scene_to_file("res://Scenes/Levels/lvl_2.tscn")
	elif(GameManager.current_level == "res://Scenes/Levels/Level2.tscn"):
		get_tree().change_scene_to_file("res://Scenes/Levels/lvl_3.tscn")
	elif(GameManager.current_level == "res://Scenes/Levels/Level3.tscn"):
		get_tree().change_scene_to_file("res://Scenes/Levels/lvl_4.tscn")
	elif(GameManager.current_level == "res://tusmuerto/nivel_4.tscn"):
		get_tree().change_scene_to_file("res://Scenes/Levels/lvl_boss.tscn")
