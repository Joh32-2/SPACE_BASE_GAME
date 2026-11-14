extends Node2D

@export var camera: Camera2D
@export var follow_speed: float = 2.0

@export_category("Configuración de la Cámara")
@export var camera_zoom: Vector2 = Vector2(1.5, 1.5) # Ajusta el zoom aquí
@export var use_limits: bool = true
@export var limit_left: int = 0
@export var limit_top: int = 0
@export var limit_right: int = 1920
@export var limit_bottom: int = 1080

var smoothing_speed: float = 2.0

func _ready() -> void:
	if camera:
		# Aplicar el zoom inicial
		camera.zoom = camera_zoom
		camera.position_smoothing_enabled
		camera.position_smoothing_speed = smoothing_speed
		# Aplicar límites si están activados
		if use_limits:
			camera.limit_left = limit_left
			camera.limit_top = limit_top
			camera.limit_right = limit_right
			camera.limit_bottom = limit_bottom

func _process(delta: float) -> void:
	if camera:
		var target_pos = get_global_mouse_position()
		camera.position = camera.position.lerp(target_pos, follow_speed * delta)
