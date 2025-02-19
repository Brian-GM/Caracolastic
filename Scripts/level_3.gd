extends Node2D

@onready var currentword: Label = $CurrentWord
@onready var type_word: Label = $TypeWord
@onready var timer: Timer = $Timer
@onready var tiempo: Label = $Tiempo
@onready var _1: Label = $"+1"
@onready var puntos: Label = $Puntos

var points = 0

var words = [
	"hotel", "animal", "salad", "mineral", "doctor", "dental", "universal", "ideal", 
	"normal", "actor", "festival", "radio", "capital", "cultural", "total", "manual", 
	"original", "fantastic", "banco", "popular", "material", "individual", "final", 
	"central", "circuit", "intelligent", "local", "natural", "mobile", "original", 
	"cultural", "color", "fiscal", "personal", "global", "legal", "cable", "horizontal", 
	"interview", "sensible", "formal", "digital", "mental", "central", "original", 
	"physical", "personal", "deluxe", "subtle", "crisis", "minimum", "manual"
]

var success_words = []

var current_word = ""
var typed_word = ""

func _ready() -> void:
	puntos.text = str(points) + " /10"
	_1.visible = false
	new_word()
	
func _process(delta: float) -> void:
	tiempo.text = str(int(timer.time_left))

	if points >= 10:
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


func _on_timer_timeout() -> void:
	print("Despedido")
