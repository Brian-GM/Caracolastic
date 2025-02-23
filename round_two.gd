extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.en_español:
		$"Round Two".text = "Ronda dos"
	else:
		$"Round Two".text = "Round Two"

	await get_tree().create_timer(3.0).timeout  # Espera 2 segundos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	print(GameManager.current_level)
	if GameManager.current_level == "res://Scenes/Levels/Level1.tscn":
		get_tree().change_scene_to_file("res://Scenes/Levels/Level1.2.tscn")
	elif(GameManager.current_level == "res://Scenes/Levels/Level2.tscn"):
		get_tree().change_scene_to_file("res://Scenes/Levels/Level2.1.tscn")
	elif(GameManager.current_level == "res://Scenes/Levels/Level3.tscn"):
		get_tree().change_scene_to_file("res://Scenes/Levels/Level3.2.tscn")
	elif(GameManager.current_level == "res://tusmuerto/nivel_4.tscn"):
		get_tree().change_scene_to_file("res://tusmuerto/nivel_4.2.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")
