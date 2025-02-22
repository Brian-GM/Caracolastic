extends Control

# Convierte un valor de 1-100 a un rango de decibeles adecuado
func convert_to_db(value: float) -> float:
	return -60 + (value / 100) * 60  # Suponiendo que el rango de volumen es de -60dB a 0dB

# Convierte de decibeles a un valor de 1-100
func convert_from_db(db_value: float) -> float:
	return ((db_value + 60) / 60) * 100  # Suponiendo que el rango de volumen es de -60dB a 0dB

func _on_volumen_value_changed(value: float) -> void:
	var db_value = convert_to_db(value)
	AudioServer.set_bus_volume_db(0, db_value)


func _on_check_button_toggled(toggled_on: bool) -> void:
	$Click.play()
	AudioServer.set_bus_mute(0, toggled_on)

func _ready():
	if AudioServer.is_bus_mute(0):
		$CheckButton.button_pressed = true
	else:
		$CheckButton.button_pressed = false

	if GameManager.en_español:
		$idioma.button_pressed = false
		$volume.text = "Volumen de musica"
		$Label3.text = "Ajustes"
		$mute.text = "Mutear"
		$OptionButton.text = "Volver"
		$IDIOMA.text = "Idioma"
		$ESP.text = "Español"
		$Ingles.text = "Ingles"
	else:
		$idioma.button_pressed = true
		$volume.text = "Music volume"
		$Label3.text = "Settings"
		$mute.text = "Mute"
		$OptionButton.text = "Back"
		$IDIOMA.text = "Language"
		$ESP.text = "Spanish"
		$Ingles.text = "English"
		
	$AnimationPlayer.play("desvanecer_entrada")
	$AnimatedSprite2D.play("default")
	var current_volume = AudioServer.get_bus_volume_db(0)
	var current_volume_effects = AudioServer.get_bus_volume_db(2)
	$Volumen.value = convert_from_db(current_volume)
	_on_volumen_value_changed($Volumen.value)
	


func _on_option_button_pressed() -> void:	
	$Click.play()
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/Levels/menu.tscn")

func _on_back_pressed() -> void:
	$Click.play()
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/Levels/menu.tscn")


func _on_idioma_toggled(toggled_on: bool) -> void:
	$Click.play()
	if toggled_on:
		GameManager.en_español = false
		$volume.text = "Music volume"
		$Label3.text = "Settings"
		$mute.text = "Mute"
		$OptionButton.text = "Back"
		$IDIOMA.text = "Language"
		$ESP.text = "Spanish"
		$Ingles.text = "English"
	else:
		GameManager.en_español = true
		$volume.text = "Volumen de musica"
		$Label3.text = "Ajustes"
		$mute.text = "Mutear"
		$OptionButton.text = "Volver"
		$IDIOMA.text = "Idioma"
		$ESP.text = "Español"
		$Ingles.text = "Ingles"
