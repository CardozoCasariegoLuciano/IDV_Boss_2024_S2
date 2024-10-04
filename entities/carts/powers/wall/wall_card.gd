extends Card_template

@export var wall_scene: PackedScene
var wall: Node

func _ready() -> void:
	require_click = true
	use_in_field = true
	
func after_set_data():
	wall = wall_scene.instantiate() as StaticBody2D
	wall.global_position = click_point
	card_target.add_child(wall)

func clean_target():
	card_target.remove_child(wall)
