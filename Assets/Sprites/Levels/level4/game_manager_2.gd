extends Node

var npcs_en_su_sitio = {}  # Diccionario para rastrear NPCs en su zona

func _ready():
	# Inicializa los NPCs como NO colocados
	npcs_en_su_sitio["NPC1"] = false
	npcs_en_su_sitio["NPC3"] = false


func verificar_victoria():
	if npcs_en_su_sitio.values().all(func(value): return value):
		cambiar_escena()

func cambiar_escena():
	print("¡Todos los NPCs están en su sitio! Cambiando de escena...")
	get_tree().change_scene_to_file("Ruta de la escena del ascensor de brian")  # Cambia la escena
