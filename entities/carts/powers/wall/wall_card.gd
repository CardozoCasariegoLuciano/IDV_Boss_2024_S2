extends Card_template
class_name Wall_card

@export var wall_scene: PackedScene
var wall: Node

func _ready() -> void:
	scene_path = preload("res://entities/carts/powers/wall/wall_card.tscn")
	use_in_field = true
	energy_cost = 15
	
func after_set_data():
	wall = wall_scene.instantiate() as StaticBody2D
	wall.global_position = self.point_target
	card_target.add_child(wall)
	wall.modulate = Color(0.6,0.6,0.6,1)
	wall.timer.start()
	
func clean_target():
	card_target.remove_child(wall)

func apply_action():
	wall.visible = true
	
func after_turn():
	if(!card_target): return
	wall.visible = false
