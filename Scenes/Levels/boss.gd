extends Control

var preguntaActual = {}
var idioma = "english"

var preguntas = {
	"español": [
		{
			"enunciado": "¿Cuál de estos objetos fue un obstáculo cuando eras limpiador?",
			"respuestas": [
				{"texto": "Estanterías", "correcta": false},
				{"texto": "Papeleras", "correcta": false},
				{"texto": "Plantas", "correcta": true},
				{"texto": "Neveras", "correcta": false}
			]
		},
		{
			"enunciado": "¿Cuáles son los alimentos que transportastes cuando eras becario?",
			"respuestas": [
				{"texto": "Café y Guisantes", "correcta": false},
				{"texto": "Café y Lechuga", "correcta": true},
				{"texto": "Agua y Guisantes", "correcta": false},
				{"texto": "Soda y Lechuga", "correcta": false}
			]
		},
		{
			"enunciado": "¿De qué color es la taza del escritorio cuando ascendistes a programador?",
			"respuestas": [
				{"texto": "Rojigualda", "correcta": false},
				{"texto": "Naranja", "correcta": false},
				{"texto": "Amarillo", "correcta": false},
				{"texto": "Verde", "correcta": true}
			]
		},
		{
			"enunciado": "¿Como Jefe de planta que responsabilidad tenías sobre tus empleados?",
			"respuestas": [
				{"texto": "Organizarlos", "correcta": true},
				{"texto": "Acosarlos", "correcta": false},
				{"texto": "Gritarles", "correcta": false},
				{"texto": "Animarles", "correcta": false},
			]
		}
	],
	"english": [
		{
			"enunciado": "Which of these objects was an obstacle when you were a cleaner?",
			"respuestas": [
				{"texto": "Shelves", "correcta": false},
				{"texto": "Trash cans", "correcta": false},
				{"texto": "Plants", "correcta": true},
				{"texto": "Fridges", "correcta": false}
			]
		},
		{
			"enunciado": "What food were you delivering when you were an intern?",
			"respuestas": [
				{"texto": "Coffee and Peas", "correcta": false},
				{"texto": "Coffee and Lettuce", "correcta": true},
				{"texto": "Water and Peas", "correcta": false},
				{"texto": "Soda and Lettuce", "correcta": false}
			]
		},
		{
			"enunciado": "What color was the cup on the desk when you were promoted to developer?",
			"respuestas": [
				{"texto": "Red and Yellow", "correcta": false},
				{"texto": "Orange", "correcta": false},
				{"texto": "Yellow", "correcta": false},
				{"texto": "Green", "correcta": true}
			]
		},
		{
			"enunciado": "As a floor manager, what responsibility did you have over your employees?",
			"respuestas": [
				{"texto": "Organize them", "correcta": true},
				{"texto": "Harass them", "correcta": false},
				{"texto": "Yell at them", "correcta": false},
				{"texto": "Encourage them", "correcta": false},
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

	$EscenaJefe.play("default")
	await(get_tree().create_timer(2.0).timeout)
	$EscenaJefe.stop()

func _on_boton_presionado(indice):
	var es_correcta = preguntaActual["respuestas"][indice]["correcta"]
	if es_correcta:
		print("¡Respuesta correcta!")
		preguntas[idioma].erase(preguntaActual)  
		mostrar_pregunta()
	else:
		print("Respuesta incorrecta.")
