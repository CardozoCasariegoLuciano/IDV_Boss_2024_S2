extends Node2D
class_name Formation_template

@onready var markers: Node2D = $markers
@onready var reference: Node2D = $reference
@onready var selected_line: Line2D = $Selected_line
@onready var click_detector: Panel = $click_detector

var scene: PackedScene

func _ready() -> void:
	set_reference_visible(false)
	set_selected_line_visible(false)

func hide_panel():
	click_detector.visible = false

func get_on_click_signal() -> Signal:
	return click_detector.on_click
	
func get_markers() -> Array[Node]:
	return markers.get_children()

func set_formation_to_player_2():
	position.x = 1120
	rotate(deg_to_rad(180))
	
func set_reference_visible(isVisible:bool):
	reference.visible = isVisible

func set_selected_line_visible(isVisible:bool):
	selected_line.visible = isVisible

func fill_marcks_width_points():
	for mark_ in markers.get_children():
		var mark = mark_ as Marker2D
		var sprite = Sprite2D.new()
		sprite.texture = preload("res://assets/players/bala_player.png")
		mark.add_child(sprite)
