extends Panel
@onready var canvas_layer: CanvasLayer = $".."
@onready var parrent_sprite: Sprite2D = $"../../Sprite2D"

func _ready() -> void:
	var fullScreen:Sprite2D = parrent_sprite.duplicate()
	fullScreen.scale = Vector2(0.8, 0.8)
	fullScreen.global_position = Vector2(553,315)
	canvas_layer.call_deferred("add_child", fullScreen)
	

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		canvas_layer.visible = false
