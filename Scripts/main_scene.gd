extends Node2D

@onready var levels = {
	"level1": preload("res://scenes/Level1.tscn"),
	"level2": preload("res://scenes/Level1.tscn"),
	"level3": preload("res://scenes/Level1.tscn"),
	"level4": preload("res://scenes/Level1.tscn"),
	"level5": preload("res://scenes/Level1.tscn"),

}


@onready var level_scene = levels.level1.instantiate()


func _ready():
	add_child(level_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
