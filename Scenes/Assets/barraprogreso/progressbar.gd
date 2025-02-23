extends Control

signal tiempo_agotado

var tiempo_restante : float = 10
var tiempo_total : float = 10
var progress_bar : ProgressBar
var tiempo_label : Label
var tiempo_agotado_emitido : bool = false

func aumentar_tiempo(segundos : float):
    tiempo_restante += segundos
    tiempo_restante = min(tiempo_restante, tiempo_total)
    tiempo_agotado_emitido = false

func _ready():
    progress_bar = $ProgressBar
    tiempo_label = $Label

    progress_bar.add_theme_color_override("fill_color", Color(0, 0, 1))
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

func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
        aumentar_tiempo(10)

func _on_tiempo_agotado():
    print("¡Tiempo agotado!")
