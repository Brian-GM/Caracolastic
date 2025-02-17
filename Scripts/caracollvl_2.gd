extends CharacterBody2D

var speed: float = 200 # Velocidad de movimiento

func _process(_delta: float) -> void:
    var direction = Vector2.ZERO

    if Input.is_action_pressed("ui_right"):
        direction.x += 1
    if Input.is_action_pressed("ui_left"):
        direction.x -= 1
    if Input.is_action_pressed("ui_down"):
        direction.y += 1
    if Input.is_action_pressed("ui_up"):
        direction.y -= 1

    if direction != Vector2.ZERO:
        velocity = direction.normalized() * speed
        rotate_character(direction)
    else:
        velocity = Vector2.ZERO

    move_and_slide()

func rotate_character(direction: Vector2) -> void:
    if direction == Vector2.RIGHT:
        rotation_degrees = 90
    elif direction == Vector2.LEFT:
        rotation_degrees = 270
    elif direction == Vector2.DOWN:
        rotation_degrees = 180
    elif direction == Vector2.UP:
        rotation_degrees = 0
    
    # TODO: HAcer la animacion ams flojita con lerp
