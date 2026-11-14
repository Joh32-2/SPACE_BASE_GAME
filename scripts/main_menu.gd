extends Control

# Declaramos las señales que el menú emitirá
signal start_new_game
signal open_options
signal quit_game

# Precargamos las rutas de las escenas basándonos en tu estructura de carpetas
@export var game_scene: PackedScene = preload("res://scenes/Marcian_base.tscn")
@export var settings_scene: PackedScene = preload("res://scenes/settings/settings.tscn")

@export_category("Referencias de Nodos")
@export var first_button_path: NodePath

func _ready() -> void:
	if not first_button_path.is_empty():
		var first_button = get_node_or_null(first_button_path)
		if first_button is Button:
			first_button.grab_focus()

# Estas funciones se ejecutan cuando se presionan los botones del menú:

func _on_new_game_pressed() -> void:
	print("Iniciando nuevo juego...")
	emit_signal("start_new_game")
	
	# Cambio directo a la escena de juego
	get_tree().change_scene_to_packed(game_scene)


func _on_options_pressed() -> void:
	print("Abriendo configuración...")
	emit_signal("open_options")
	
	# Opción 1: Si prefieres cambiar de escena por completo hacia settings:
	get_tree().change_scene_to_packed(settings_scene)
	
	# Opción 2 (Alternativa): Si prefieres que el menú de ajustes aparezca 
	# flotando encima sin borrar el menú principal, descomenta las siguientes 2 líneas:
	# var settings_instance = settings_scene.instantiate()
	# get_tree().root.add_child(settings_instance)


func _on_quit_pressed() -> void:
	print("Saliendo del juego...")
	emit_signal("quit_game")
	get_tree().quit()
