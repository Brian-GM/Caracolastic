extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("desvanecer_entrada")
	await get_tree().create_timer(1.0).timeout  # Espera 2 segundos
	if GameManager.en_español:
		$esp.play()
	else:
		$ing.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_esp_finished() -> void:
	await get_tree().create_timer(2.0).timeout  # Espera 2 segundos
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout  # Espera 2 segundos
	get_tree().change_scene_to_file("res://Scenes/Levels/lvl_1.tscn")


func _on_ing_finished() -> void:
	await get_tree().create_timer(2.0).timeout  # Espera 2 segundos
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout  # Espera 2 segundos
	get_tree().change_scene_to_file("res://Scenes/Levels/lvl_1.tscn")


func _on_mostrar_2_timeout() -> void:
	$"tapar 2".visible = false



func _on_mostrar_3_timeout() -> void:
	$"tapar 3".visible = false



func _on_mostrar_4_timeout() -> void:
	$"tapar 4".visible = false




func _on_eus_timeout() -> void:
	$Eusx.visible = false
	await get_tree().create_timer(1.0).timeout  # Espera 2 segundos
	$"tapar 1".visible = false
