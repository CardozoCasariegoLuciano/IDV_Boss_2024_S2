extends Panel
signal on_click

@onready var formation: Formation_template = $".."

func _on_gui_input(event: InputEvent) -> void:
	if(event is InputEventMouseButton and event.button_index == 1 and !event.pressed):
		on_click.emit(formation)
