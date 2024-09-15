extends Panel
signal on_cart_used

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	print("llega una carta")
	on_cart_used.emit(data)
