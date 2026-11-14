extends StaticBody2D

@export var speed: float = 400.0

func _physics_process(delta: float) -> void:
	var direction := 0.0
	
	if Input.is_key_pressed(KEY_W):
		direction -= 1.0
	if Input.is_key_pressed(KEY_S):
		direction += 1.0
		
	position.y += direction * speed * delta
	
	position.y = clamp(position.y, 50, 598)
