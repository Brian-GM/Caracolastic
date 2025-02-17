extends CharacterBody2D

var speed: float = 500
var direction: Vector2 = Vector2.ZERO
var moving: bool = false
var RASTRO_BABA = preload("res://Scenes/rastro_baba.tscn")  

func _process(delta: float) -> void:
	if not moving:
		if Input.is_action_just_pressed("ui_right"):
			direction = Vector2.RIGHT
			moving = true
		elif Input.is_action_just_pressed("ui_left"):
			direction = Vector2.LEFT
			moving = true
		elif Input.is_action_just_pressed("ui_up"):
			direction = Vector2.UP
			moving = true
		elif Input.is_action_just_pressed("ui_down"):
			direction = Vector2.DOWN
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
	nueva_baba.position = self.position - Vector2(0, -200) # Ajusta el valor según necesites
	
	
	get_parent().add_child(nueva_baba)
