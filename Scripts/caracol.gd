extends CharacterBody2D

var speed: float = 500
var direction: Vector2 = Vector2.ZERO
var moving: bool = false
var RASTRO_BABA = preload("res://Scenes/rastro_baba.tscn")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	if not moving:
		if Input.is_action_just_pressed("ui_right"):
			direction = Vector2.RIGHT
			self.rotation_degrees = 0  # Girar hacia la derecha
			moving = true
		elif Input.is_action_just_pressed("ui_left"):
			direction = Vector2.LEFT
			self.rotation_degrees = 180  # Girar hacia la izquierda
			moving = true
		elif Input.is_action_just_pressed("ui_up"):
			direction = Vector2.UP
			self.rotation_degrees = -90  # Girar hacia arriba
			moving = true
		elif Input.is_action_just_pressed("ui_down"):
			direction = Vector2.DOWN
			self.rotation_degrees = 90  # Girar hacia abajo
			moving = true

	if moving:
		move(delta)
		baba()

func move(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		if collision.get_collider().is_in_group("baba"):
			moving = false
			direction = Vector2.ZERO
		else:
			moving = false
			direction = Vector2.ZERO

func baba():
	var nueva_baba = RASTRO_BABA.instantiate()
	var offset = Vector2(81, 0)  
	offset = offset.rotated(self.rotation)
	nueva_baba.position = self.position - offset
	get_parent().add_child(nueva_baba)
