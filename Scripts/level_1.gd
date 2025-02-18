extends Node2D
@onready var mierdas: Node2D = $Mierdas
@onready var tiempo: Label = $Tiempo
@onready var timer: Timer = $Timer

var maximo_mierdecitas = 10

var mierdecitas_actuales = 10

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	tiempo.text = str(int(timer.time_left))
	if mierdas.get_child_count() <= 0:
		get_tree().change_scene_to_file("res://Scenes/Levels/Level2.tscn")


func _on_timer_timeout() -> void:
	print("Despedido")
