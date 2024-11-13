extends Panel

@onready var panel: Panel = $"."

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data.change_card_visibility(true)
	panel.visible = false

func _on_mouse_entered() -> void:
	if(!Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		panel.visible = false

func _on_end_turn_button_gui_input(event: InputEvent) -> void:
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		panel.visible = true
