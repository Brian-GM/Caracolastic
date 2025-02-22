extends Node

var npcs_en_su_sitio = {}  # Diccionario para rastrear NPCs en su zona

func _ready():
	# Inicializa los NPCs como NO colocados

	npcs_en_su_sitio["NPC1"] = false
	npcs_en_su_sitio["NPC3"] = false


func verificar_victoria():
	if npcs_en_su_sitio.values().all(func(value): return value):
		await get_tree().create_timer(1).timeout
		cambiar_escena()

func cambiar_escena():
	get_tree().change_scene_to_file("res://Scenes/stonks/jefepasado.tscn")  # Cambia la escena
