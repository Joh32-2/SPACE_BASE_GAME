extends StaticBody2D

@export var speed: float = 400.0

func _physics_process(delta: float) -> void:
	var direction := 0.0
	
	if Input.is_key_pressed(KEY_UP):
		direction -= 1.0
	if Input.is_key_pressed(KEY_DOWN):
		direction += 1.0
		
	position.y += direction * speed * delta
	
	position.y = clamp(position.y, 50, 598)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
