extends Control
@onready var ascensor: AnimatedSprite2D = $ascensor
@onready var open: AnimatedSprite2D = $open
@onready var close: AnimatedSprite2D = $close
@onready var musica_ascensor: AudioStreamPlayer2D = $Musica_ascensor

var canciones = [
	"res://Assets/Music/Soundtrack/ascensor1.mp3",
	"res://Assets/Music/Soundtrack/ascensor2.mp3",
	"res://Assets/Music/Soundtrack/ascensor3.mp3"
]

func reproducir_musica_aleatoria() -> void:
	var cancion_aleatoria = canciones[randi_range(0,canciones.size() - 1)]
	var audio_stream = load(cancion_aleatoria)
	if audio_stream:
		musica_ascensor.stream = audio_stream
		musica_ascensor.play()

func _ready() -> void:
	$AnimationPlayer.play("desvanecer_entrada")

	close.visible = true
		
	if GameManager.en_español:
		$TextoESP.visible = true
	else:
		$TextoIng.visible = true

func _on_timer_timeout() -> void:
	close.visible = false
	open.visible = true
	open.play("default")


func _on_open_animation_finished() -> void:
	open.visible = false
	open.stop()
	ascensor.play("default")
	await get_tree().create_timer(5.0).timeout
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout  # Espera 2 segundos
	get_tree().change_scene_to_file("res://Scenes/stonks/limpieza.tscn")
	
func _on_timer_2_timeout() -> void:
	$pliopen.play()



func _on_timer_3_timeout() -> void:
	reproducir_musica_aleatoria()


func _on_pliopen_finished() -> void:
	pass # Replace with function body.


func _on_timer_4_timeout() -> void:
	pass # Replace with function body.
