extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	velocity.x = 5  # Velocidad en píxeles por segundo hacia la derecha
	move_and_slide()
