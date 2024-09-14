extends Panel
@onready var color_rect: ColorRect = $"../ColorRect"
@onready var card: Node2D = $".."


func _get_drag_data(at_position: Vector2) -> Variant:
	if color_rect.color.a == 0:
		return
	var preview_color = ColorRect.new()
	preview_color.color.r = color_rect.color.r - 0.1
	preview_color.color.g = color_rect.color.g - 0.1
	preview_color.color.b = color_rect.color.b - 0.1
	preview_color.set_size(color_rect.size * 0.7)
	
	var preview = Control.new()
	preview.add_child(preview_color)
	
	set_drag_preview(preview)
	color_rect.color.a = 0
	return card

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

#Emitir una señal al padre para que realice una accion
func _drop_data(at_position: Vector2, data: Variant) -> void:
	data.change_card_visibility(1)
