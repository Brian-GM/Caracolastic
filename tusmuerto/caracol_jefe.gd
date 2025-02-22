extends CharacterBody2D

@export var speed: int = 200

func _physics_process(delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		$Sprite2D.scale.x = 1  # Mirar a la derecha
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
		$Sprite2D.scale.x = -1 # Mirar a la izquierda
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1

	direction = direction.normalized()
	var collision = move_and_collide(direction * speed * delta)

	# Si choca con un NPC, intenta empujarlo
	if collision:
		var collider = collision.get_collider()
		if collider is CharacterBody2D and collider.name in ["NPC1", "NPC2", "NPC3", "NPC4"]:
			collider.move_and_collide(direction * 32) # Empuja al NPC en la dirección del golpe
