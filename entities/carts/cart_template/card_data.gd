extends Node
class_name CardData

var scene: PackedScene
var player_1_quantity: int
var player_2_quantity: int
var default_quantity: int
var step_quantity: int

func set_values(scene_: PackedScene, 
		player_1_quantity_: int, 
		player_2_quantity_: int, 
		default_quantity_: int, 
		step_quantity_: int) -> CardData:
	scene = scene_
	player_1_quantity = player_1_quantity_
	player_2_quantity = player_2_quantity_
	default_quantity = default_quantity_
	step_quantity = step_quantity_
	return self
