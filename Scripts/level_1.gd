extends Node2D
@onready var mierdas: Node2D = $Mierdas
@onready var tiempo: Label = $Tiempo
@onready var timer: Timer = $Timer
@onready var puntos: Label = $Puntos
var total_mierdas = 20  # Cantidad inicial

func _ready() -> void:
	GameManager.current_level = "res://Scenes/Levels/Level1.tscn"

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	puntos.text = str(total_mierdas - mierdas.get_child_count()) + "/20"
	tiempo.text = str(int(timer.time_left))
	if mierdas.get_child_count() <= 0:
		get_tree().change_scene_to_file("res://Scenes/Levels/lvl_2.tscn")


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/despedido.tscn")
