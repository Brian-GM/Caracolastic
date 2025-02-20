extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	$Play.visible = true
	$Menu.visible = true

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(GameManager.current_level)



func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/menu.tscn")


func _on_sello_timeout() -> void:
	$sello_sprite.visible = true	
	$AudioStreamPlayer2D2.play()
