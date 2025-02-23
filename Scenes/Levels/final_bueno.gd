extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("desvanecer_entrada")
	GameManager.final_2_desbloque = true
	if GameManager.en_español:
		$Label.text = "Eres un digno sucesor,
							dame la mano"
		$Label2.text = "Eres una BABOSA
						¡¡¡DESPEDIDO!!!"
	else:
		$Label.text = "You are a worthy successor,
							give me your hand"
		$Label2.text = "You are a SLUG!!!
						¡¡¡FIRED!!!"
# Called every frame. 'delta' is the elapsed time since the previous frame.
	$habla.play()
	$FinalBueno.play("default")
	$Label.visible = true
	await get_tree().create_timer(3).timeout 
	$habla.play()

	$Label.visible = false
	$Label2.visible = true



func _process(delta: float) -> void:
	pass


func _on_fin_timeout() -> void:
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/creditos.tscn")


func _on_sello_timeout() -> void:
	$sello_sprite.visible = true	
	$AudioStreamPlayer2D2.play()
