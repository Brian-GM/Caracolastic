extends CharacterBody2D

# El NPC no se mueve solo, solo se mueve cuando el jugador lo empuja
var moving = false
var move_direction = Vector2.ZERO

func _physics_process(delta):
	if moving:
		move_and_collide(move_direction * 32) # Se mueve una casilla
		moving = false # Detiene el movimiento después de un paso
