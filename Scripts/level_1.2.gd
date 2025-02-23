extends Node2D
@onready var mierdas: Node2D = $Mierdas
@onready var tiempo: Label = $Tiempo
@onready var timer: Timer = $Timer
@onready var puntos: Label = $Puntos
var total_mierdas = 15
var puntos_previos: int = 0  

func _ready() -> void:    
	$Progressbar.connect("tiempo_agotado", Callable(self, "_on_temporizador_tiempo_agotado"))

	$AnimationPlayer.play("desvanecer_entrada")
	GameManager.current_level = "res://Scenes/Levels/Level1.2.tscn"
	$Progressbar.set_tiempo_total(60)


# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	var puntos_actuales = total_mierdas - mierdas.get_child_count()
	if puntos_actuales != puntos_previos:
		puntos_previos = puntos_actuales
		$pedo.play()


	puntos.text = str(total_mierdas - mierdas.get_child_count()) + "/15"
	tiempo.text = str(int(timer.time_left))
	if mierdas.get_child_count() <= 0:
		$AnimationPlayer.play("desvanecer_salir")
		await get_tree().create_timer(1.0).timeout 
		get_tree().change_scene_to_file("res://Scenes/stonks/limpiadorpasado.tscn")


func _on_temporizador_tiempo_agotado():
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/Levels/despedido.tscn")
