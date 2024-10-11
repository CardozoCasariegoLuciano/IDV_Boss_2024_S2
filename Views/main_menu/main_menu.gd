extends CanvasLayer


func _on_new_game() -> void:
	get_tree().change_scene_to_file("res://Views/pre_game/pre_game.tscn")


func _on_config() -> void:
	print("Ir a la pantalla de config")
