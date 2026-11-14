extends Node2D

@export var camera: Camera2D
@export var follow_speed: float = 1.0
@export var background: Sprite2D

@export_category("Configuración de la Cámara")
@export var camera_zoom: Vector2 = Vector2(1, 1)
@export var use_limits: bool = true
@export var limit_left: int = 0
@export var limit_top: int = 0
@export var limit_right: int = 1920
@export var limit_bottom: int = 1080

var zone = 1
var last_zone = -1 # Variable para rastrear cambios de zona
var zoom = false
var debounce_time = 0.2

# Banderas de control de debounce (evitan que se ejecute mientras espera)
var can_click: bool = true
var can_change_zone: bool = true

# Precargamos las texturas al iniciar la escena para que no causen lag
var tex_zone_1 = preload("res://assets/images.jpeg")
var tex_zone_2 = preload("res://assets/icon.svg")
var tex_zone_3 = preload("res://assets/images.jpeg")
var tex_zone_4 = preload("res://assets/images.jpeg")

func _ready() -> void:
	var window_size = get_window().size
	if camera:
		# Aplicar el zoom inicial y centrar la cámara
		camera.position = window_size / 2.0
		camera.zoom = camera_zoom
		
		# Aplicar límites si están activados
		if use_limits:
			camera.limit_left = limit_left
			camera.limit_top = limit_top
			camera.limit_right = limit_right
			camera.limit_bottom = limit_bottom
			
	# Establecer la textura inicial al arrancar
	update_background_texture()

func _process(delta: float) -> void:
	# Corregido: Permite que la zona 4 se alcance antes de reiniciar a 1
	if zone > 4:
		zone = 1
	elif zone < 1:
		zone = 4

	# Solo actualizamos la textura si la zona cambió (evita sobrecargar el procesador)
	if zone != last_zone:
		update_background_texture()

	if camera:
		var target_pos = get_global_mouse_position()
		camera.position = camera.position.lerp(target_pos, follow_speed * delta)
		
		# Aplicar el zoom según el estado de la variable booleana
		if zoom:
			camera.zoom = Vector2(1.5, 1.5)
		else:
			camera.zoom = camera_zoom

# El clic del mouse se gestiona aquí de forma segura con debounce
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not can_click:
			return # Si está en tiempo de espera, ignorar el clic
		
		can_click = false
		zoom = !zoom
		
		# Esperar el tiempo de debounce de forma segura
		await get_tree().create_timer(debounce_time).timeout
		can_click = true

# Función auxiliar para cambiar las texturas de forma limpia
func update_background_texture() -> void:
	last_zone = zone
	match zone:
		1:
			background.texture = tex_zone_1
		2:
			background.texture = tex_zone_2
		3:
			background.texture = tex_zone_3
		4:
			background.texture = tex_zone_4

func _on_area_2d_mouse_entered() -> void:
	if not can_change_zone:
		return # Si el área está en tiempo de espera, ignorar
		
	can_change_zone = false
	zone += 1
	camera.position = Vector2(0.0, 0.0)
	zoom = false
	
	await get_tree().create_timer(debounce_time).timeout
	can_change_zone = true


func _on_area_2d_2_mouse_entered() -> void:
	if not can_change_zone:
		return # Si el área está en tiempo de espera, ignorar
		
	can_change_zone = false
	zone -= 1
	camera.position = Vector2(0.0, 0.0)
	
	
	await get_tree().create_timer(debounce_time).timeout
	can_change_zone = true
