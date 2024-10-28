extends Card_template

@export var wall_scene: PackedScene
var wall: Node

func _ready() -> void:
	scene_path = preload("res://entities/carts/powers/wall/wall_card.tscn")
	require_click = true
	use_in_field = true
	energy_cost = 15
	
func after_set_data():
	wall = wall_scene.instantiate() as StaticBody2D
	wall.global_position = click_value
	card_target.add_child(wall)

func clean_target():
	card_target.remove_child(wall)
