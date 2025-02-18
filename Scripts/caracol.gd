extends CharacterBody2D
var first_frame: bool = true  # Variable para detectar el primer frame

var speed: float = 500
var direction: Vector2 = Vector2.ZERO
var moving: bool = false
var RASTRO_BABA = preload("res://Scenes/Assets/rastro_baba.tscn")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var last_baba_position: Vector2 = Vector2.ZERO
var distance_threshold: float = 78  # Ajusta según sea necesario
@onready var collision_container: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	last_baba_position = self.position  # Guarda la posición inicial
	create_baba()  # Crea la primera baba en la posición inicial

func _process(delta: float) -> void:
	if first_frame:
		create_baba()
		first_frame = false  # Se ejecuta solo una vez

	if not moving:
		if Input.is_action_just_pressed("ui_left"):
			direction.x = -1
			moving = true
		elif Input.is_action_just_pressed("ui_right"):
			direction.x = 1
			moving = true
		elif Input.is_action_just_pressed("ui_up"):
			direction.y = -1
			moving = true
		elif Input.is_action_just_pressed("ui_down"):
			direction.y = 1
			moving = true

	# Mantener la hitbox sin rotación
	collision_container.rotation_degrees = 0


	if moving:
		move(delta)
		if self.position.distance_to(last_baba_position) >= distance_threshold:
			create_baba()
			last_baba_position = self.position

func move(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		await get_tree().create_timer(0.10).timeout
		if collision.get_collider().is_in_group("baba"):
			moving = false
			direction = Vector2.ZERO
		else:
			moving = false
			direction = Vector2.ZERO

func create_baba():
	var nueva_baba = RASTRO_BABA.instantiate()
	nueva_baba.position = self.position
	get_parent().add_child(nueva_baba)
