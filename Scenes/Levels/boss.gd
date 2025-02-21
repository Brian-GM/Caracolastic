extends Control

var preguntaActual = {}
var idioma = "english"

var preguntas = {
	"español": [
		{
			"enunciado": "tetas",
			"respuestas": [
				{"texto": "Gordas", "correcta": true},
				{"texto": "Flacas", "correcta": false},
				{"texto": "Medianas", "correcta": false},
				{"texto": "Pequeñas", "correcta": false}
			]
		},
		{
			"enunciado": "¿Cuál es la capital de España?",
			"respuestas": [
				{"texto": "Barcelona", "correcta": false},
				{"texto": "Madrid", "correcta": true},
				{"texto": "Valencia", "correcta": false},
				{"texto": "Sevilla", "correcta": false}
			]
		}
	],
	"english": [
		{
			"enunciado": "What is the capital of Spain?",
			"respuestas": [
				{"texto": "Barcelona", "correcta": false},
				{"texto": "Madrid", "correcta": true},
				{"texto": "Valencia", "correcta": false},
				{"texto": "Sevilla", "correcta": false}
			]
		},
		{
			"enunciado": "What is the capital of France?",
			"respuestas": [
				{"texto": "Paris", "correcta": true},
				{"texto": "Lyon", "correcta": false},
				{"texto": "Marseille", "correcta": false},
				{"texto": "Toulouse", "correcta": false}
			]
		}
	]
}

@onready var label_pregunta = $Label
@onready var botones = $VBoxContainer.get_children()

func _ready():
	idioma = "español" if GameManager.en_español else "english"
	mostrar_pregunta()

func mostrar_pregunta():
	if preguntas[idioma].is_empty():
		print("¡Has terminado!")
		return

	var indice = randi() % preguntas[idioma].size()
	preguntaActual = preguntas[idioma][indice]
	label_pregunta.text = preguntaActual["enunciado"]

	for i in range(botones.size()):
		botones[i].text = preguntaActual["respuestas"][i]["texto"]
		botones[i].connect("pressed", _on_boton_presionado.bind(i))

func _on_boton_presionado(indice):
	var es_correcta = preguntaActual["respuestas"][indice]["correcta"]
	if es_correcta:
		print("¡Respuesta correcta!")
		preguntas[idioma].erase(preguntaActual)  
		mostrar_pregunta()
	else:
		print("Respuesta incorrecta.")
