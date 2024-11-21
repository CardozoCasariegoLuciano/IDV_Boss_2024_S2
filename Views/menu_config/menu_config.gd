extends Node2D
signal _on_close

func _on_close_button_up() -> void:
	_on_close.emit()
	queue_free()
