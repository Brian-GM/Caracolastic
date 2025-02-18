extends StaticBody2D
@onready var collision_shape_2d_2: CollisionShape2D = $CollisionShape2D2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_shape_2d_2.disabled = true
	$Area2D.connect("body_exited", Callable(self, "_on_area_2d_body_exited"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("caracol"):
		print("Fuera")
		await get_tree().process_frame  # Espera un frame antes de habilitar la colisión
		collision_shape_2d_2.disabled = false
