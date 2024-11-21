extends CanvasLayer

var is_config_open = false

func _on_new_game() -> void:
	get_tree().change_scene_to_file("res://Views/pre_game/pre_game.tscn")


func _on_config() -> void:
	if(!is_config_open):
		var config_view = preload("res://Views/menu_config/menu_config.tscn").instantiate()
		config_view._on_close.connect(_on_close_config)
		add_child(config_view)
		is_config_open = true

func _on_close_config():
	is_config_open = false
