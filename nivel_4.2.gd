extends Node

var npcs_en_su_sitio = {}  # Diccionario para rastrear NPCs en su zona

var npc_totales:int = 2
var nps_ensusitio:int=0
func _ready():
	$Progressbar.connect("tiempo_agotado", Callable(self, "_on_temporizador_tiempo_agotado"))
	$Progressbar.set_tiempo_total(75)

	GameManager.current_level  = "res://tusmuerto/nivel_4.2.tscn"
	$AnimationPlayer.play("desvanecer_entrada")


	# Inicializa los NPCs como NO colocados
	npcs_en_su_sitio["NPC1"] = false
	npcs_en_su_sitio["NPC3"] = false
func _process(delta: float) -> void:
	$Puntos.text = str(nps_ensusitio) + " / " + str(npc_totales)


func verificar_victoria():
	if npcs_en_su_sitio.values().all(func(value): return value):
		cambiar_escena()

func cambiar_escena():
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/Levels/lvl_boss.tscn")
	
func _on_temporizador_tiempo_agotado():
	$AnimationPlayer.play("desvanecer_salir")
	await get_tree().create_timer(1.0).timeout 
	get_tree().change_scene_to_file("res://Scenes/Levels/despedido.tscn")
