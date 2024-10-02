extends Panel
@onready var canvas_layer: CanvasLayer = $".."
@onready var fullscreen_sprite: Sprite2D = $"../Sprite2D"
@onready var parrent_sprite: Sprite2D = $"../../Sprite2D"

func _ready() -> void:
	fullscreen_sprite.texture = parrent_sprite.texture

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		canvas_layer.visible = false
