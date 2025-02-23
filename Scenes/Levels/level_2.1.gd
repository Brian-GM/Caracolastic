extends Node2D


func _ready() -> void:
	$Progressbar.connect("tiempo_agotado", Callable(self, "_on_temporizador_tiempo_agotado"))
	$Progressbar.set_tiempo_total(60)

	$AnimationPlayer.play("desvanecer_entrada")
	GameManager.current_level = "res://Scenes/Levels/Level2.1.tscn"
func _on_temporizador_tiempo_agotado():
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/Levels/despedido.tscn")
