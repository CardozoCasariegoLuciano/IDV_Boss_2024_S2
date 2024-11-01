extends Panel
@onready var node: Node2D = $".."


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		node.visible = false
