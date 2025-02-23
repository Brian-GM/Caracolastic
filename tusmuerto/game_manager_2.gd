extends Node

var npcs_en_su_sitio = {}  # Diccionario para rastrear NPCs en su zona

func _ready():
	# Inicializa los NPCs como NO colocados
	npcs_en_su_sitio["NPC1"] = false
	npcs_en_su_sitio["NPC3"] = false

# Acepta un AnimationPlayer como parámetro
func verificar_victoria(animation_player: AnimationPlayer):
	if npcs_en_su_sitio.values().all(func(value): return value):
		await get_tree().create_timer(1).timeout
		cambiar_escena(animation_player)  # Pasa el AnimationPlayer a cambiar_escena

# Acepta un AnimationPlayer como parámetro
func cambiar_escena(animation_player: AnimationPlayer):
	animation_player.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/round_two.tscn")  # Cambia la escena
