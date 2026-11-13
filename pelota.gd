extends CharacterBody2D

@export var velocidad_inicial: float = 400.0
var velocidad_actual: Vector2 = Vector2.ZERO

func _ready() -> void:
	reiniciar_pelota()

func _physics_process(delta: float) -> void:
	velocity = velocidad_actual
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var collider = collision.get_collider()
		velocidad_actual = velocidad_actual.bounce(collision.get_normal())

func reiniciar_pelota() -> void:
	position = Vector2(576, 324) # Centro de la pantalla (1152x648)
	
	var dir_x = 1.0 if randf() > 0.5 else -1.0
	var dir_y = randf_range(-0.6, 0.6)
	
	velocidad_actual = Vector2(dir_x, dir_y).normalized() * velocidad_inicial
