extends Panel

@onready var cart: ColorRect = $".."

func _get_drag_data(at_position: Vector2) -> Variant:
	if cart.color.a == 0:
		return
	var preview_color = ColorRect.new()
	preview_color.color.r = cart.color.r - 0.1
	preview_color.color.g = cart.color.g - 0.1
	preview_color.color.b = cart.color.b - 0.1
	preview_color.set_size(cart.size * 0.7)
	
	var preview = Control.new()
	preview.add_child(preview_color)
	
	set_drag_preview(preview)
	cart.color.a = 0
	return cart

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

#Emitir una señal al padre para que realice una accion
func _drop_data(at_position: Vector2, data: Variant) -> void:
	data.color.a = 1
