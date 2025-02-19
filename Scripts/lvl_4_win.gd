extends Control
@onready var ascensor: AnimatedSprite2D = $ascensor
@onready var open: AnimatedSprite2D = $open
@onready var close: AnimatedSprite2D = $close


func _ready() -> void:
	close.visible = true

func _on_timer_timeout() -> void:
	close.visible = false
	open.visible = true
	open.play("default")


func _on_open_animation_finished() -> void:
	open.visible = false
	open.stop()
	ascensor.play("default")
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://Scenes/Levels/Level4.tscn")
	
