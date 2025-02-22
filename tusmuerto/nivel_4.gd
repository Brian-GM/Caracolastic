extends Node

var npcs_en_su_sitio = {}  # Diccionario para rastrear NPCs en su zona

func _ready():
	GameManager.current_level  = "res://tusmuerto/nivel_4.tscn"
	$AnimationPlayer.play("desvanecer_entrada")


	# Inicializa los NPCs como NO colocados
	npcs_en_su_sitio["NPC1"] = false
	npcs_en_su_sitio["NPC3"] = false


func verificar_victoria():
	if npcs_en_su_sitio.values().all(func(value): return value):
		cambiar_escena()

func cambiar_escena():
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/Levels/lvl_boss.tscn")
