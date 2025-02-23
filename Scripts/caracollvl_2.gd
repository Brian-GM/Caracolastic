extends CharacterBody2D

var speed: float = 400
var cafe1Recogido: bool = false
var cafe2Recogido: bool = false
var lechuga1Recogida: bool = false
var lechuga2Recogida: bool = false
var mesas: Array = []
var mesa_seleccionada: Node2D = null
var pideCafe: bool = false
var pideLechuga: bool = false
var mirando_a_derecha: bool
var cafe_en_bandeja: bool
var lechuga_en_bandeja: bool

var pedidos_totales:int = 10
var pedidos_completados:int = 0


# Texturas para los pedidos
var textura_2cafes = preload("res://Assets/Sprites/Characters/Bocadillo2Cafes.png")
var textura_cafe = preload("res://Assets/Sprites/Characters/BocadilloCafe.png")
var textura_2lechugas = preload("res://Assets/Sprites/Characters/Bocadillo2Lechugas.png")
var textura_cafe_lechuga = preload("res://Assets/Sprites/Characters/BocadilloCafeYLechuga.png")
var textura_lechuga = preload("res://Assets/Sprites/Characters/BocadilloLechuga.png")

# Variable para almacenar la última mesa atendida
var ultima_mesa_atendida: int = -1

func _ready() -> void:
	# Inicializar las mesas
	for i in range(1, 7):
		var nombremesa = "Mesa" + str(i)
		var mesa = get_node("../Mesa" + str(i))
		if mesa:
			var sprite_pedido = mesa.get_node("SpritePedido") as Sprite2D
			var mesa_incrustada = {
				"node": mesa,
				"name": nombremesa,
				"cafe": false,
				"lechuga": false,
				"atendida": false,  # Nueva propiedad para marcar si la mesa fue atendida
				"cafe_entregado": false,  # Rastrear si se ha entregado el café
				"lechuga_entregada": false,  # Rastrear si se ha entregado la lechuga
				"sprite_pedido": sprite_pedido  # Referencia al Sprite2D de la mesa
			}
			mesas.append(mesa_incrustada)
	
	# Asignar pedidos a 3 mesas aleatorias
	asignar_pedidos_a_mesas()

	seleccionar_mesa()

func asignar_pedidos_a_mesas() -> void:
	# Reiniciar el estado de todas las mesas
	for mesa in mesas:
		mesa.cafe = false
		mesa.lechuga = false
		mesa.atendida = false
		mesa.cafe_entregado = false
		mesa.lechuga_entregada = false
		mesa.sprite_pedido.visible = false  # Ocultar el sprite del pedido
	
	# Crear una lista de índices de mesas, excluyendo la última mesa atendida
	var indices_mesas = range(mesas.size())
	if ultima_mesa_atendida != -1:
		indices_mesas.erase(ultima_mesa_atendida)  # Excluir la última mesa atendida
	
	# Mezclar los índices aleatoriamente
	indices_mesas.shuffle()
	# Seleccionar las primeras 3 mesas
	var mesas_seleccionadas = indices_mesas.slice(0, 3)
	
	# Asignar pedidos a las mesas seleccionadas
	for i in mesas_seleccionadas:
		var pedido = asignar_pedido_aleatorio()
		mesas[i].cafe = pedido.cafe
		mesas[i].lechuga = pedido.lechuga
		
		# Mostrar el pedido de la mesa por consola
		var pedido_texto = "Pedido de " + mesas[i].name + ": "
		if pedido.cafe and pedido.lechuga:
			pedido_texto += "Café y Lechuga"
			mesas[i].sprite_pedido.texture = textura_cafe_lechuga
		elif pedido.cafe:
			pedido_texto += "Café"
			mesas[i].sprite_pedido.texture = textura_cafe
		elif pedido.lechuga:
			pedido_texto += "Lechuga"
			mesas[i].sprite_pedido.texture = textura_lechuga
		
		mesas[i].sprite_pedido.visible = true  # Mostrar el sprite del pedido
		print(pedido_texto)

func asignar_pedido_aleatorio() -> Dictionary:
	var opciones = [
		{"cafe": true, "lechuga": false},  # Café
		{"cafe": true, "lechuga": true},   # Café y Lechuga
		{"cafe": false, "lechuga": true},  # Lechuga
		{"cafe": true, "lechuga": false},  # Café y Café (se maneja en la lógica de recogida)
		{"cafe": false, "lechuga": true}   # Lechuga y Lechuga (se maneja en la lógica de recogida)
	]
	return opciones[randi() % opciones.size()]

func seleccionar_mesa() -> void:
	# Lógica para seleccionar una mesa (puedes implementarla según tus necesidades)
	pass

func _process(_delta: float) -> void:
	$"../Puntos".text = str(pedidos_completados) + "/" + str(pedidos_totales)

	if pedidos_completados >= pedidos_totales:
		$"../AnimationPlayer".play("desvanecer_salir")
		await get_tree().create_timer(1.0).timeout 
		get_tree().change_scene_to_file("res://Scenes/round_two.tscn")
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

	if mirando_a_derecha:
		$CaracolSprite.flip_h = false
		$Bandeja.flip_h = false
		$Bandeja.position.x =- 30
		$Bandeja/Cafe1.flip_h = false
		$Bandeja/Cafe1.position.x =- 15
		$Bandeja/Cafe2.flip_h = false
		$Bandeja/Cafe2.position.x =+ 20
		$Bandeja/Lechuga1.flip_h = false
		$Bandeja/Lechuga1.position.x =- 10
		$Bandeja/Lechuga2.flip_h = false
		$Bandeja/Lechuga2.position.x =+ 28
	else:
		$CaracolSprite.flip_h = true
		$Bandeja.flip_h = true
		$Bandeja.position.x =+ 30
		$Bandeja/Cafe1.flip_h = true
		$Bandeja/Cafe1.position.x =+ 15
		$Bandeja/Cafe2.flip_h = true
		$Bandeja/Cafe2.position.x =- 20
		$Bandeja/Lechuga1.flip_h = true
		$Bandeja/Lechuga1.position.x =+ 10
		$Bandeja/Lechuga2.flip_h = true
		$Bandeja/Lechuga2.position.x =- 28

	if cafe1Recogido or cafe2Recogido:
		cafe_en_bandeja = true
		#%SonidoBasura.play()
	else:
		#%SonidoCafe.play()
		cafe_en_bandeja = false
		
	if lechuga1Recogida or lechuga2Recogida:
		lechuga_en_bandeja = true
		#%SonidoBasura.play()
	else:
		#%SonidoLechuga.play()
		lechuga_en_bandeja = false
		
	move_and_slide()

func rotate_character(direction: Vector2) -> void:
	if direction == Vector2.RIGHT:
		mirando_a_derecha = true
	elif direction == Vector2.LEFT:
		mirando_a_derecha = false

func _on_recoger_cafe_body_entered(_body: Node2D) -> void:
	if not cafe1Recogido and not cafe2Recogido and lechuga1Recogida and not lechuga2Recogida:
		cafe2Recogido = true
		$Bandeja/Cafe2.visible = true
		cafe1Recogido = false
		$Bandeja/Cafe1.visible = false
		%SonidoCafe.play()
		print("Café 2 recogido.")
	elif cafe1Recogido and lechuga2Recogida:
		cafe2Recogido = false
		$Bandeja/Cafe2.visible = false
		print("No puedes cogerlo.")
	elif not cafe1Recogido and lechuga1Recogida and lechuga2Recogida:
		cafe2Recogido = false
		$Bandeja/Cafe2.visible = false
		print("No puedes cogerlo.")
	elif not cafe1Recogido and not lechuga1Recogida:
		cafe1Recogido = true
		$Bandeja/Cafe1.visible = true
		%SonidoCafe.play()
		print("Café 1 recogido.")    
	elif not cafe2Recogido and lechuga1Recogida and not lechuga2Recogida:
		cafe2Recogido = true
		$Bandeja/Cafe2.visible = true
		%SonidoCafe.play()
		print("Café recogido.")
	elif not cafe2Recogido and lechuga1Recogida and lechuga2Recogida:
		cafe2Recogido = false
		$Bandeja/Cafe2.visible = false
		print("No puedes cogerlo")
	elif not cafe1Recogido and lechuga1Recogida and not lechuga2Recogida and not cafe2Recogido:
		cafe1Recogido = true
		$Bandeja/Cafe1.visible = true
		%SonidoCafe.play()
		print("Café recogido.")
	elif not cafe1Recogido and lechuga1Recogida and lechuga2Recogida:
		cafe1Recogido = false
		$Bandeja/Cafe1.visible = false
		print("No puedes cogerlo")
	elif not cafe2Recogido and cafe1Recogido:
		cafe2Recogido = true
		$Bandeja/Cafe2.visible = true
		%SonidoCafe.play()
		print("Café recogido.")
	elif not cafe2Recogido and lechuga2Recogida:
		cafe2Recogido = false
		$Bandeja/Cafe2.visible = false
		print("No puedes cogerlo")
	elif lechuga1Recogida and lechuga2Recogida:
		cafe1Recogido = false
		cafe2Recogido = false
		$Bandeja/Cafe1.visible = false
		$Bandeja/Cafe2.visible = false
		print("No puedes llevar más cosas en la bandeja. 2x Lechuga recogida.")
	elif lechuga1Recogida and cafe2Recogido and not cafe1Recogido and not lechuga2Recogida:
		print("No puedes llevar más cosas en la bandeja.")
		
func _on_recoger_lechuga_body_entered(_body: Node2D) -> void:
	if not lechuga1Recogida and cafe1Recogido and not cafe2Recogido and not lechuga2Recogida:
		lechuga2Recogida = true
		$Bandeja/Lechuga2.visible = true
		%SonidoLechuga.play()
		print("Lechuga 2 recogida.")
	elif cafe1Recogido and lechuga2Recogida and not cafe2Recogido and not lechuga1Recogida:
		cafe2Recogido = false
		$Bandeja/Cafe2.visible = false
		print("No puedes cogerlo.")
	elif not lechuga1Recogida and not cafe1Recogido and not cafe2Recogido:
		lechuga1Recogida = true
		$Bandeja/Lechuga1.visible = true
		%SonidoLechuga.play()
		print("Lechuga 1 recogida.")
	elif not lechuga2Recogida and cafe1Recogido and not cafe2Recogido:
		lechuga2Recogida = true
		$Bandeja/Lechuga2.visible = true
		%SonidoLechuga.play()
		print("Lechuga 2 recogida.")
	elif not lechuga2Recogida and lechuga1Recogida and not cafe2Recogido and not cafe1Recogido:
		lechuga2Recogida = true
		$Bandeja/Lechuga2.visible = true
		%SonidoLechuga.play()
		print("Lechuga 2 recogida.")
	elif lechuga1Recogida and lechuga2Recogida:
		print("No puedes llevar más cosas en la bandeja. 2x Lechuga recogida.")
	elif cafe1Recogido and cafe2Recogido and not lechuga1Recogida and not lechuga2Recogida:
		lechuga1Recogida = false
		lechuga2Recogida = false
		$Bandeja/Lechuga1.visible = false
		$Bandeja/Lechuga2.visible = false
		print("No puedes llevar más cosas en la bandeja.")
	elif lechuga1Recogida and cafe2Recogido and not cafe1Recogido and not lechuga2Recogida:
		print("No puedes llevar más cosas en la bandeja.")

func _on_tirar_cafe_body_entered(_body: Node2D) -> void:
	if cafe1Recogido:
		cafe1Recogido = false
		$Bandeja/Cafe1.visible = false
		%SonidoBasura.play()
		print("Café desechado.")
	elif cafe2Recogido:
		cafe2Recogido = false
		$Bandeja/Cafe2.visible = false
		%SonidoBasura.play()
		print("Café desechado.")

func _on_tirar_lechuga_body_entered(_body: Node2D) -> void:
	if lechuga1Recogida:
		lechuga1Recogida = false
		$Bandeja/Lechuga1.visible = false
		%SonidoBasura.play()
		print("Lechuga desechada.")
	elif lechuga2Recogida:
		lechuga2Recogida = false
		$Bandeja/Lechuga2.visible = false
		%SonidoBasura.play()
		print("Lechuga desechada.")

func entregar_pedido(mesa_index: int) -> void:
	var mesa = mesas[mesa_index]
	if not mesa.atendida:
		if mesa.cafe and mesa.lechuga:
			# Pedido de Café y Lechuga
			if not mesa.cafe_entregado and not mesa.lechuga_entregada:
				# Verificar si ambos productos están en la bandeja
				if cafe_en_bandeja and lechuga_en_bandeja:
					# Entregar ambos productos
					if cafe1Recogido:
						cafe1Recogido = false
						$Bandeja/Cafe1.visible = false
					else:
						cafe2Recogido = false
						$Bandeja/Cafe2.visible = false
					
					if lechuga1Recogida:
						lechuga1Recogida = false
						$Bandeja/Lechuga1.visible = false
					else:
						lechuga2Recogida = false
						$Bandeja/Lechuga2.visible = false
					
					mesa.cafe_entregado = true
					mesa.lechuga_entregada = true
					mesa.atendida = true
					mesa.sprite_pedido.visible = false  # Ocultar el sprite del pedido
					%PedidoCompletado.play()
					print("Café y Lechuga entregados en " + mesa.name + ". Pedido completado.")
					pedidos_completados += 2
					$"../Progressbar".aumentar_tiempo(2)

				elif cafe_en_bandeja:
					# Entregar solo el café
					if cafe1Recogido:
						cafe1Recogido = false
						$Bandeja/Cafe1.visible = false
					else:
						cafe2Recogido = false
						$Bandeja/Cafe2.visible = false
					
					mesa.cafe_entregado = true
					mesa.sprite_pedido.texture = textura_lechuga  # Cambiar el sprite para mostrar que falta la lechuga
					%PedidoAMedias.play()
					print("Café entregado en " + mesa.name + ". Falta la lechuga.")
					
				elif lechuga_en_bandeja:
					# Entregar solo la lechuga
					if lechuga1Recogida:
						lechuga1Recogida = false
						$Bandeja/Lechuga1.visible = false
					else:
						lechuga2Recogida = false
						$Bandeja/Lechuga2.visible = false
					
					mesa.lechuga_entregada = true
					mesa.sprite_pedido.texture = textura_cafe  # Cambiar el sprite para mostrar que falta el café
					%PedidoAMedias.play()
					print("Lechuga entregada en " + mesa.name + ". Falta el café.")
				else:
					%Error.play()
					print("No tienes café ni lechuga para " + mesa.name)
			elif mesa.cafe_entregado and not mesa.lechuga_entregada:
				# Segunda entrega: solo se puede entregar la lechuga
				if lechuga_en_bandeja:
					if lechuga1Recogida:
						lechuga1Recogida = false
						$Bandeja/Lechuga1.visible = false
					else:
						lechuga2Recogida = false
						$Bandeja/Lechuga2.visible = false
					
					mesa.lechuga_entregada = true
					mesa.atendida = true
					mesa.sprite_pedido.visible = false  # Ocultar el sprite del pedido
					%PedidoCompletado.play()
					print("Lechuga entregada en " + mesa.name + ". Pedido completado.")
					pedidos_completados += 2
					$"../Progressbar".aumentar_tiempo(2)

				else:
					%Error.play()
					print("No tienes lechuga para completar el pedido en " + mesa.name)
			elif not mesa.cafe_entregado and mesa.lechuga_entregada:
				# Segunda entrega: solo se puede entregar el café
				if cafe_en_bandeja:
					if cafe1Recogido:
						cafe1Recogido = false
						$Bandeja/Cafe1.visible = false
					else:
						cafe2Recogido = false
						$Bandeja/Cafe2.visible = false
					
					mesa.cafe_entregado = true
					mesa.atendida = true
					mesa.sprite_pedido.visible = false  # Ocultar el sprite del pedido
					%PedidoCompletado.play()
					print("Café entregado en " + mesa.name + ". Pedido completado.")
					pedidos_completados += 2
					$"../Progressbar".aumentar_tiempo(2)

				else:
					%Error.play()
					print("No tienes café para completar el pedido en " + mesa.name)
		
		elif mesa.cafe:
			# Pedido de Café
			if cafe_en_bandeja:
				mesa.atendida = true
				if cafe1Recogido:
					cafe1Recogido = false
					$Bandeja/Cafe1.visible = false
				else:
					cafe2Recogido = false
					$Bandeja/Cafe2.visible = false
				
				mesa.sprite_pedido.visible = false  # Ocultar el sprite del pedido
				%PedidoCompletado.play()
				print("Pedido de café entregado en " + mesa.name)
				pedidos_completados += 1
				$"../Progressbar".aumentar_tiempo(1)

			else:
				%Error.play()
				print("No tienes café para " + mesa.name)
				
		elif mesa.lechuga:
			# Pedido de Lechuga
			if lechuga_en_bandeja:
				mesa.atendida = true
				if lechuga1Recogida:
					lechuga1Recogida = false
					$Bandeja/Lechuga1.visible = false
				else:
					lechuga2Recogida = false
					$Bandeja/Lechuga2.visible = false
				
				mesa.sprite_pedido.visible = false  # Ocultar el sprite del pedido
				%PedidoCompletado.play()
				print("Pedido de lechuga entregado en " + mesa.name)
				pedidos_completados += 1
				$"../Progressbar".aumentar_tiempo(1)

			else:
				%Error.play()
				print("No tienes lechuga para " + mesa.name)
		
		# Verificar si todos los pedidos han sido entregados
		if todos_los_pedidos_entregados():
			print("¡Todos los pedidos han sido entregados! Asignando nuevos pedidos...")
			ultima_mesa_atendida = mesa_index  # Guardar la última mesa atendida
			asignar_pedidos_a_mesas()
			
func todos_los_pedidos_entregados() -> bool:
	for mesa in mesas:
		if (mesa.cafe or mesa.lechuga) and not mesa.atendida:
			# Si es un pedido de "Café y Lechuga", verificar si ambos productos han sido entregados
			if mesa.cafe and mesa.lechuga:
				if not mesa.cafe_entregado or not mesa.lechuga_entregada:
					return false  # Aún falta entregar un producto
			else:
				return false  # Aún hay pedidos pendientes
	return true  # Todos los pedidos han sido entregados

func _on_mesa_1_body_entered(body: Node2D) -> void:
	if body == self:
		entregar_pedido(0)

func _on_mesa_2_body_entered(body: Node2D) -> void:
	if body == self:
		entregar_pedido(1)

func _on_mesa_3_body_entered(body: Node2D) -> void:
	if body == self:
		entregar_pedido(2)

func _on_mesa_4_body_entered(body: Node2D) -> void:
	if body == self:
		entregar_pedido(3)

func _on_mesa_5_body_entered(body: Node2D) -> void:
	if body == self:
		entregar_pedido(4)

func _on_mesa_6_body_entered(body: Node2D) -> void:
	if body == self:
		entregar_pedido(5)
