extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("desvanecer_entrada")
	GameManager.current_level = "res://Scenes/Levels/Level2.tscn"

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/Levels/despedido.tscn")
