extends CharacterBody2D

var speed: float = 200
var cafeRecogido: bool = false
var lechugaRecogida: bool = false
var mesas: Array = []
var mesa_seleccionada: Node2D = null
var pideCafe: bool = false
var pideLechuga: bool = false
var segundos: int = 15
var tiempo_acumulado: float = 0.0



func _ready() -> void:
	for i in range(1, 7):
		var nombremesa = ""
		var cafe = false
		var lechuga = false

		var mesa = get_node("../Mesa" + str(i))
		if mesa:
			nombremesa = "Mesa" + str(i)
			var random = randi() % 2
			if random == 0:
				cafe = true
				random = randi() % 2
				if random == 0:
					lechuga = true
				else:
					lechuga = false
			else:
				cafe = false
				lechuga = true

			var mesa_incrustada = {
					"node": mesa,
					"name": nombremesa,
					"cafe": cafe,
					"lechuga": lechuga
				}
			mesas.append(mesa_incrustada)
			
	# mostrar mesas
	for mesa in mesas:
		print(mesa.name + " - Café: " + str(mesa.cafe) + " - Lechuga: " + str(mesa.lechuga))

	seleccionar_mesa()

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

func _on_recoger_cafe_body_entered(_body: Node2D) -> void:
	if not cafeRecogido:
		cafeRecogido = true
		print("Café recogido.")

func _on_recoger_lechuga_body_entered(_body: Node2D) -> void:
	if not lechugaRecogida:
		lechugaRecogida = true
		print("Lechuga recogida.")


func _on_tirar_cafe_body_entered(_body: Node2D) -> void:
	if cafeRecogido:
		cafeRecogido = false
		print("Café deshechado.")

func _on_tirar_lechuga_body_entered(_body: Node2D) -> void:
	if lechugaRecogida:
		lechugaRecogida = false
		print("Lechuga deshechada.")

func seleccionar_mesa() -> void:
	if mesas.size() > 0:
		var indice = randi() % mesas.size()
		mesa_seleccionada = mesas[indice]["node"]
		pideCafe = mesas[indice]["cafe"]
		pideLechuga = mesas[indice]["lechuga"]
		actualizar_cartel()

func actualizar_cartel() -> void:
	if mesa_seleccionada:
		print("Dirígete a: " + mesa_seleccionada.name)
		print("Café: " + str(pideCafe) + " - Lechuga: " + str(pideLechuga))

func actualizar_tiempo(delta: float) -> void:
	tiempo_acumulado += delta
	if tiempo_acumulado >= 1.0:
		tiempo_acumulado -= 1.0
		segundos = max(0, segundos - 1)
		# print("Tiempo restante: " + str(segundos))
		# if segundos <= 0:
			# print("Tiempo agotado.")


func _on_mesa_1_body_entered(_body: Node2D) -> void:
	if "Mesa1" == mesa_seleccionada.name:
		if pideCafe == cafeRecogido and pideLechuga == lechugaRecogida:
			cafeRecogido = false
			lechugaRecogida = false
			mesas.erase(mesa_seleccionada)
			mesa_seleccionada = null
			segundos += 10
			if mesas.size() == 0:
				print("No quedan más mesas.")
			else:
				seleccionar_mesa()
		else:
			print("No has traido la comanda correcta, deshecha lo que no se ha requerido y recoge lo que se te ha pedido.")	



func _on_mesa_2_body_entered(_body: Node2D) -> void:
	if "Mesa2" == mesa_seleccionada.name:
		if pideCafe == cafeRecogido and pideLechuga == lechugaRecogida:
			cafeRecogido = false
			lechugaRecogida = false
			mesas.erase(mesa_seleccionada)
			mesa_seleccionada = null
			segundos += 10
			if mesas.size() == 0:
				print("No quedan más mesas.")
			else:
				seleccionar_mesa()
		else:
			print("No has traido la comanda correcta, deshecha lo que no se ha requerido y recoge lo que se te ha pedido.")	


func _on_mesa_3_body_entered(_body: Node2D) -> void:
	if "Mesa3" == mesa_seleccionada.name:
		if pideCafe == cafeRecogido and pideLechuga == lechugaRecogida:
			cafeRecogido = false
			lechugaRecogida = false
			mesas.erase(mesa_seleccionada)
			mesa_seleccionada = null
			segundos += 10
			if mesas.size() == 0:
				print("No quedan más mesas.")
			else:
				seleccionar_mesa()
		else:
			print("No has traido la comanda correcta, deshecha lo que no se ha requerido y recoge lo que se te ha pedido.")	


func _on_mesa_4_body_entered(_body: Node2D) -> void:
	if "Mesa4" == mesa_seleccionada.name:
		if pideCafe == cafeRecogido and pideLechuga == lechugaRecogida:
			cafeRecogido = false
			lechugaRecogida = false
			mesas.erase(mesa_seleccionada)
			mesa_seleccionada = null
			segundos += 10
			if mesas.size() == 0:
				print("No quedan más mesas.")
			else:
				seleccionar_mesa()
		else:
			print("No has traido la comanda correcta, deshecha lo que no se ha requerido y recoge lo que se te ha pedido.")	

func _on_mesa_5_body_entered(_body: Node2D) -> void:
	if "Mesa5" == mesa_seleccionada.name:
		if pideCafe == cafeRecogido and pideLechuga == lechugaRecogida:
			cafeRecogido = false
			lechugaRecogida = false
			mesas.erase(mesa_seleccionada)
			mesa_seleccionada = null
			segundos += 10
			if mesas.size() == 0:
				print("No quedan más mesas.")
			else:
				seleccionar_mesa()
		else:
			print("No has traido la comanda correcta, deshecha lo que no se ha requerido y recoge lo que se te ha pedido.")	


func _on_mesa_6_body_entered(_body: Node2D) -> void:
	if "Mesa6" == mesa_seleccionada.name:
		if pideCafe == cafeRecogido and pideLechuga == lechugaRecogida:
			cafeRecogido = false
			lechugaRecogida = false
			mesas.erase(mesa_seleccionada)
			mesa_seleccionada = null
			segundos += 10
			if mesas.size() == 0:
				print("No quedan más mesas.")
			else:
				seleccionar_mesa()
		else:
			print("No has traido la comanda correcta, deshecha lo que no se ha requerido y recoge lo que se te ha pedido.")	
			



