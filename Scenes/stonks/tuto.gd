extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("desvanecer_entrada")	
	if GameManager.current_level == "res://Scenes/Levels/Level1.2.tscn":
		$Becario.visible = true
	elif(GameManager.current_level == "res://Scenes/Levels/Level2.1.tscn"):
		$Type.visible = true
	elif(GameManager.current_level == "res://Scenes/Levels/Level3.2.tscn"):
		$Gerente.visible = true
	elif(GameManager.current_level == "res://tusmuerto/nivel_4.2.tscn"):
		$Boss.visible = true

	else:
		$Limpieza.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	if GameManager.current_level == "res://Scenes/Levels/Level1.2.tscn":
		get_tree().change_scene_to_file("res://Scenes/Levels/Level2.tscn")
	elif(GameManager.current_level == "res://Scenes/Levels/Level2.1.tscn"):
		get_tree().change_scene_to_file("res://Scenes/Levels/Level3.tscn")
	elif(GameManager.current_level == "res://Scenes/Levels/Level3.2.tscn"):
		get_tree().change_scene_to_file("res://tusmuerto/nivel_4.tscn")
	elif(GameManager.current_level == "res://tusmuerto/nivel_4.2.tscn"):
		get_tree().change_scene_to_file("res://Scenes/Levels/Boss.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")
