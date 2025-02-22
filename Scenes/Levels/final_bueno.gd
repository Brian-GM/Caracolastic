extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("desvanecer_entrada")
	await get_tree().create_timer(1.0).timeout  # Espera 2 segundos
	GameManager.final_2_desbloque = true
	if GameManager.en_español:
		$Label.text = "¡¡¡Eres una BABOSA!!!"
		$Label2.text = "¡¡¡DESPEDIDO!!!"
	else:
		$Label.text = "You are a SLUG!!!"
		$Label2.text = "¡¡¡FIRED!!!"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fin_timeout() -> void:
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/Levels/menu.tscn")


func _on_sello_timeout() -> void:
	$sello_sprite.visible = true	
	$AudioStreamPlayer2D2.play()
