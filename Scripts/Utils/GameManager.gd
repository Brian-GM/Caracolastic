extends Node

var firs_time = true
var current_level = ""
var en_español = false
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("")
	elif Input.is_action_just_pressed("ui_restart"):
		get_tree().reload_current_scene()
