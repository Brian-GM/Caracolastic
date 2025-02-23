extends Control

signal tiempo_agotado

var tiempo_restante : float = 10
var tiempo_total : float = 10
var progress_bar : ProgressBar
var tiempo_label : Label
var tiempo_agotado_emitido : bool = false

# Función para cambiar el tiempo_total
func set_tiempo_total(nuevo_tiempo: float):
	tiempo_total = nuevo_tiempo
	tiempo_restante = nuevo_tiempo  # Reinicia el tiempo restante
	progress_bar.max_value = nuevo_tiempo  # Actualiza el valor máximo de la ProgressBar
	progress_bar.value = nuevo_tiempo  # Actualiza el valor actual de la ProgressBar
	tiempo_label.text = str(int(nuevo_tiempo))  # Actualiza el texto del Label

func aumentar_tiempo(segundos : float):
	tiempo_restante += segundos
	tiempo_restante = min(tiempo_restante, tiempo_total)
	tiempo_agotado_emitido = false

func _ready():
	progress_bar = $ProgressBar
	tiempo_label = $Label
	progress_bar.add_theme_color_override("fill_color", Color(193, 242, 197))
	
	
	progress_bar.max_value = tiempo_total

	connect("tiempo_agotado", _on_tiempo_agotado)
	set_process_input(true)

func _process(delta):
	if tiempo_restante > 0:
		tiempo_restante -= delta
		tiempo_restante = max(tiempo_restante, 0)  # Asegurar que no baje de 0
		progress_bar.value = tiempo_restante
		tiempo_label.text = str(int(tiempo_restante))

	if tiempo_restante <= 0 and not tiempo_agotado_emitido:
		tiempo_restante = 0
		tiempo_label.text = "0"
		tiempo_agotado_emitido = true
		emit_signal("tiempo_agotado")

func _on_tiempo_agotado():
	print("¡Tiempo agotado!")
