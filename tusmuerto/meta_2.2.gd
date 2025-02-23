extends Area2D

@export var npc_name: String = "NPC3" # Nombre del NPC que debe estar aquí
@onready var game_manager = get_node("/root/game_manager_2_1")
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _on_area_entered(area: Area2D) -> void:
	print("entro")
	print(area.name)
	if area.name == npc_name:
		game_manager.npcs_en_su_sitio[npc_name] = true
		$correcta.play()
		$"..".nps_ensusitio += 1
		game_manager.verificar_victoria(animation_player)
	else:
		$mal.play()


func _on_area_exited(area: Area2D) -> void:
	if area.name == npc_name:
		print("salio")
		game_manager.npcs_en_su_sitio[npc_name] = false
