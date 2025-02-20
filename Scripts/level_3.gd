extends Node2D

@onready var currentword: Label = $CurrentWord
@onready var type_word: Label = $TypeWord
@onready var timer: Timer = $Timer
@onready var tiempo: Label = $Tiempo
@onready var _1: Label = $"+1"
@onready var puntos: Label = $Puntos
@onready var guiones: Label = $Guiones

var points = 0

var words = [
	"hotel", "radio", "total", "final", "local", "legal", "color", "cable", 
	"crisis", "manual", "ideal", "normal", "actor", "banco", "fiscal", "dental", 
	"doctor", "movil", "mental", "formal", "digital", "global", "animal",
	"virus", "motor", "piano", "metro", "robot", "puma", "pasta", "floral", 
	"motel", "tropical", "brutal", "fatal", "lunar", "solar", "rural", "polar", 
	"legal", "visual", "basico", "mágico"
];

var marca = "_"
var success_words = []

var current_word = ""
var typed_word = ""


func _ready() -> void:
	$AnimationPlayer.play("desvanecer_entrada")

	GameManager.current_level = "res://Scenes/Levels/Level3.tscn"
	puntos.text = str(points) + " /10"
	_1.visible = false
	new_word()
	
func _process(delta: float) -> void:
	tiempo.text = str(int(timer.time_left))
	guiones.text = marca

	if points >= 10:
		$AnimationPlayer.play("desvanecer_salir")
		await get_tree().create_timer(1.0).timeout  # Espera 2 segundos
		get_tree().change_scene_to_file("res://Scenes/Levels/lvl_4.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key_unicode = event.unicode
		if key_unicode > 0:
			var letter = char(key_unicode)

			## Si la letra es la correcta, añadirla
			if typed_word.length() < current_word.length() and letter == current_word[typed_word.length()]:
				typed_word += letter
				print(typed_word)
				type_word.text = typed_word
				type_word.add_theme_color_override("font_color", Color(0, 1, 0, 1))  # Verde
				marca += "_"
			
				## Si se completó la palabra, mostrar una nueva
				if typed_word == current_word:
					success_words.append(current_word)
					points += 1
					_1.visible = true
					puntos.text = str(points) + " /10"
					await get_tree().create_timer(1).timeout
					_1.visible = false

					new_word()
			else:
				type_word.add_theme_color_override("font_color", Color(1, 0, 0, 1)) 
				await get_tree().create_timer(0.3).timeout
				type_word.add_theme_color_override("font_color", Color(0, 1, 0, 1)) 




func new_word() -> void:
	var num_random = randi() % words.size()
	current_word = words[num_random]
	
	# Verificar si la palabra ya está en success_words
	while current_word in success_words:
		num_random = randi() % words.size()
		current_word = words[num_random]
	
	currentword.text = current_word
	typed_word = ""
	type_word.text = typed_word
	marca = "_"


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout  # Espera 2 segundos
	get_tree().change_scene_to_file("res://Scenes/Levels/despedido.tscn")
