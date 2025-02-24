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
	"tropical",
	"capital",
	"control",
	"digital",
	"editor",
	"formal",
	"global",
	"natural",
	"original",
	"personal",
	"universal",
	"virtual",
	"animal",
	"manual",
	"criminal",
	"festival",
	"hospital",
	"marginal",
	"musical",
	"radical",
	"ritual",
	"terminal",
	"usual",
	"visual"
];

var marca = "_"
var success_words = []

var current_word = ""
var typed_word = ""


func _ready() -> void:

	$Progressbar.connect("tiempo_agotado", Callable(self, "_on_temporizador_tiempo_agotado"))
	$Progressbar.set_tiempo_total(60)

	$AnimationPlayer.play("desvanecer_entrada")

	GameManager.current_level = "res://Scenes/Levels/Level3.2.tscn"
	puntos.text = str(points) + "/15"
	_1.visible = false
	new_word()
	
func _process(delta: float) -> void:
	tiempo.text = str(int(timer.time_left))
	guiones.text = marca

	if points >= 15:
		$AnimationPlayer.play("desvanecer_salir")
		await get_tree().create_timer(1.0).timeout  # Espera 2 segundos
		get_tree().change_scene_to_file("res://Scenes/stonks/programadorpasado.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		$AudioStreamPlayer2D.play()
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
					$AudioStreamPlayer2D2.play()
					_1.visible = true
					puntos.text = str(points) + "/15"
					await get_tree().create_timer(1).timeout
					_1.visible = false

					new_word()
			else:
				pass




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


func _on_temporizador_tiempo_agotado():
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/Levels/despedido.tscn")
