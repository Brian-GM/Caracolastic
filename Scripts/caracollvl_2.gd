extends CharacterBody2D

var speed: float = 200
var cafe: bool = false
var mesas: Array = []
var mesa_seleccionada: Node2D = null
var segundos: int = 15
var tiempo_acumulado: float = 0.0



func _ready() -> void:
	for i in range(1, 7):
		var mesa = get_node("../Mesa" + str(i))
		if mesa:
			mesas.append(mesa)

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
	actualizar_tiempo(_delta)

func rotate_character(direction: Vector2) -> void:
	if direction == Vector2.RIGHT:
		rotation_degrees = 90
	elif direction == Vector2.LEFT:
		rotation_degrees = 270
	elif direction == Vector2.DOWN:
		rotation_degrees = 180
	elif direction == Vector2.UP:
		rotation_degrees = 0

func _on_recoger_body_entered(_body: Node2D) -> void:
	if not cafe:
		cafe = true
		seleccionar_mesa()

func seleccionar_mesa() -> void:
	if mesas.size() > 0:
		var indice = randi() % mesas.size()
		mesa_seleccionada = mesas[indice]
		actualizar_cartel()

func actualizar_cartel() -> void:
	if mesa_seleccionada:
		print("Dirígete a: " + mesa_seleccionada.name)  # Aquí puedes actualizar un Label en la interfaz

func actualizar_tiempo(delta: float) -> void:
	tiempo_acumulado += delta
	if tiempo_acumulado >= 1.0:
		tiempo_acumulado -= 1.0
		segundos = max(0, segundos - 1)
		print("Tiempo restante: " + str(segundos))
		if segundos <= 0:
			print("Tiempo agotado.")


func _on_mesa_1_body_entered(_body: Node2D) -> void:
	if cafe and "Mesa1" == mesa_seleccionada.name:
		cafe = false
		mesas.erase(mesa_seleccionada)
		mesa_seleccionada = null
		segundos += 10
		if mesas.size() == 0:
			print("No quedan más mesas.")
		else:
			print("Vuelve a por otro café.")



func _on_mesa_2_body_entered(_body: Node2D) -> void:
	if cafe and "Mesa2" == mesa_seleccionada.name:
		cafe = false
		mesas.erase(mesa_seleccionada)
		mesa_seleccionada = null
		segundos += 10
		if mesas.size() == 0:
			print("No quedan más mesas.")
		else:
			print("Vuelve a por otro café.")


func _on_mesa_3_body_entered(_body: Node2D) -> void:
	if cafe and "Mesa3" == mesa_seleccionada.name:
		cafe = false
		mesas.erase(mesa_seleccionada)
		mesa_seleccionada = null
		segundos += 10
		if mesas.size() == 0:
			print("No quedan más mesas.")
		else:
			print("Vuelve a por otro café.")


func _on_mesa_4_body_entered(_body: Node2D) -> void:
	if cafe and "Mesa4" == mesa_seleccionada.name:
		cafe = false
		mesas.erase(mesa_seleccionada)
		mesa_seleccionada = null
		segundos += 10
		if mesas.size() == 0:
			print("No quedan más mesas.")
		else:
			print("Vuelve a por otro café.")

func _on_mesa_5_body_entered(_body: Node2D) -> void:
	if cafe and "Mesa5" == mesa_seleccionada.name:
		cafe = false
		mesas.erase(mesa_seleccionada)
		mesa_seleccionada = null
		segundos += 10
		if mesas.size() == 0:
			print("No quedan más mesas.")
		else:
			print("Vuelve a por otro café.")


func _on_mesa_6_body_entered(_body: Node2D) -> void:
	if cafe and "Mesa6" == mesa_seleccionada.name:
		cafe = false
		mesas.erase(mesa_seleccionada)
		mesa_seleccionada = null
		segundos += 10
		if mesas.size() == 0:
			print("No quedan más mesas.")
		else:
			print("Vuelve a por otro café.")
			