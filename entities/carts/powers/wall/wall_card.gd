extends Card_template

@export var wall_scene: PackedScene
var wall: Node
var click_value: Vector2
var has_created_wall = false

func _ready() -> void:
	scene_path = preload("res://entities/carts/powers/wall/wall_card.tscn")
	require_click = true
	use_in_field = true
	energy_cost = 15

func _input(event):
	if(!card_target or has_created_wall): return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			wall = wall_scene.instantiate() as StaticBody2D
			wall.global_position = event.position
			card_target.add_child(wall)
			has_created_wall = true

func clean_target():
	card_target.remove_child(wall)

func apply_action():
	wall.visible = true
	
func after_turn():
	if(!card_target): return
	wall.visible = false
