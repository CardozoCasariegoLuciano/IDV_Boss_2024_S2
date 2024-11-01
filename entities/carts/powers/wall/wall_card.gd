extends Card_template

@export var wall_scene: PackedScene
var wall: Node
var can_rotate = false
var timer: Timer

func _ready() -> void:
	scene_path = preload("res://entities/carts/powers/wall/wall_card.tscn")
	require_click = true
	use_in_field = true
	energy_cost = 15
	init_timer()

func init_timer():
	timer = Timer.new()
	timer.wait_time = 3 
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", on_timer_timeout)
	
func on_timer_timeout():
	can_rotate = false
	wall.modulate = Color(1,1,1,1)
	
func after_set_data():
	wall = wall_scene.instantiate() as StaticBody2D
	wall.global_position = self.point_target
	card_target.add_child(wall)
	can_rotate = true
	wall.modulate = Color(0.6,0.6,0.6,1)
	timer.start()
	
func _input(event: InputEvent) -> void:
	if(!wall or !can_rotate): return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			wall.rotation += .4
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			wall.rotation -= .4

func clean_target():
	card_target.remove_child(wall)

func apply_action():
	wall.visible = true
	
func after_turn():
	if(!card_target): return
	wall.visible = false
