extends StaticBody2D

@onready var collision_shape_2d_2: CollisionShape2D = $CollisionShape2D2

func _ready() -> void:
	collision_shape_2d_2.disabled = true
	$Area2D.connect("body_exited", Callable(self, "_on_area_2d_body_exited"))

func _process(delta: float) -> void:
	pass

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("caracol"):
		await get_tree().process_frame  # Espera un frame antes de habilitar la colisión
		collision_shape_2d_2.disabled = false
