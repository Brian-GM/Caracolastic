extends CharacterBody2D

var first_frame: bool = true  # Variable para detectar el primer frame
var speed: float =300
var direction: Vector2 = Vector2.ZERO
var moving: bool = false
var rastro_baba_vertical = preload("res://Scenes/Assets/rastro_baba_vertical.tscn")
var rastro_baba_horizontal = preload("res://Scenes/Assets/rastro_baba_horizontal.tscn")
var rastro_baba_esquina_abajo_derecha = preload("res://Scenes/Assets/rastro_baba_esquina_abajo_derecha.tscn")
var rastro_baba_esquina_abajo_izquierda = preload("res://Scenes/Assets/rastro_baba_esquina_abajo_izquierda.tscn")
var rastro_baba_esquina_arriba_derecha = preload("res://Scenes/Assets/rastro_baba_esquina_arriba_derecha.tscn")
var rastro_baba_esquina_arriba_izquierda = preload("res://Scenes/Assets/rastro_baba_esquina_arriba_izquierda.tscn")
var collision_position: Vector2 = Vector2.ZERO  # Guarda la posición de la colisión
var waiting_for_new_movement: bool = false  # Indica si estamos esperando un nuevo movimiento

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var last_baba_position: Vector2 = Vector2.ZERO
var distance_threshold: float = 76  # Ajusta este valor para que las babas estén más cerca
@onready var collision_container: CollisionShape2D = $CollisionShape2D

var last_direction: Vector2 = Vector2.ZERO  # Almacena la dirección anterior

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	if first_frame:
		#create_baba_esquina(collision_position, last_direction, direction)
		first_frame = false  # Se ejecuta solo una vez

	if not moving:
		if Input.is_action_just_pressed("ui_left"):
			direction = Vector2.LEFT
			animated_sprite_2d.rotation_degrees = 270
			moving = true
			check_and_create_baba_esquina()  # Verificar si hay una colisión pendiente
		elif Input.is_action_just_pressed("ui_right"):
			direction = Vector2.RIGHT
			animated_sprite_2d.rotation_degrees = 90
			moving = true
			check_and_create_baba_esquina()  # Verificar si hay una colisión pendiente
		elif Input.is_action_just_pressed("ui_up"):
			direction = Vector2.UP
			animated_sprite_2d.rotation_degrees = 0
			moving = true
			check_and_create_baba_esquina()  # Verificar si hay una colisión pendiente
		elif Input.is_action_just_pressed("ui_down"):
			direction = Vector2.DOWN
			animated_sprite_2d.rotation_degrees = 180
			moving = true
			check_and_create_baba_esquina()  # Verificar si hay una colisión pendiente

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
		# Guardar la posición de la colisión
		collision_position = self.position
		waiting_for_new_movement = true  # Esperar a que el caracol inicie un nuevo movimiento
		moving = false
		direction = Vector2.ZERO
func check_and_create_baba_esquina():
	if waiting_for_new_movement:
		create_baba_esquina(collision_position, last_direction, direction)
		waiting_for_new_movement = false  # Reiniciar el estado
func create_baba():
	var nueva_baba
	if direction.x != 0:  # Movimiento horizontal
		nueva_baba = rastro_baba_horizontal.instantiate()
	else:  # Movimiento vertical
		nueva_baba = rastro_baba_vertical.instantiate()
	
	nueva_baba.position = self.position
	nueva_baba.z_index = 0
	get_parent().add_child(nueva_baba)

	last_direction = direction
	last_baba_position = self.position
func create_baba_esquina(position: Vector2, last_dir: Vector2, current_dir: Vector2):
	var nueva_baba_esquina

	# Lógica para determinar el tipo de esquina
	if last_dir == Vector2.LEFT:
		if current_dir == Vector2.UP:
			nueva_baba_esquina = rastro_baba_esquina_abajo_izquierda.instantiate()
		elif current_dir == Vector2.DOWN:
			nueva_baba_esquina = rastro_baba_esquina_arriba_izquierda.instantiate()
	elif last_dir == Vector2.RIGHT:
		if current_dir == Vector2.UP:
			nueva_baba_esquina = rastro_baba_esquina_abajo_derecha.instantiate()
		elif current_dir == Vector2.DOWN:
			nueva_baba_esquina = rastro_baba_esquina_arriba_derecha.instantiate()
	elif last_dir == Vector2.UP:
		if current_dir == Vector2.LEFT:
			nueva_baba_esquina = rastro_baba_esquina_arriba_derecha.instantiate()
		elif current_dir == Vector2.RIGHT:
			nueva_baba_esquina = rastro_baba_esquina_arriba_izquierda.instantiate()
	elif last_dir == Vector2.DOWN:
		if current_dir == Vector2.LEFT:
			nueva_baba_esquina = rastro_baba_esquina_abajo_derecha.instantiate()
		elif current_dir == Vector2.RIGHT:
			nueva_baba_esquina = rastro_baba_esquina_abajo_izquierda.instantiate()

	if nueva_baba_esquina:
		nueva_baba_esquina.position = position
		nueva_baba_esquina.z_index = 0
		get_parent().add_child(nueva_baba_esquina)
