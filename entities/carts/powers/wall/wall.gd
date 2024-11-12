extends StaticBody2D

var timer: Timer
var can_rotate = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_timer()
	
func init_timer():
	timer = Timer.new()
	timer.wait_time = 3 
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", on_timer_timeout)
	
func on_timer_timeout():
	can_rotate = false
	modulate = Color(1,1,1,1)
	collision_layer = 1
	collision_mask = 1

func _input(event: InputEvent) -> void:
	if(!can_rotate): return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			rotation += .4
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			rotation -= .4

func _on_body_detector(body: Node2D) -> void:
	if(!can_rotate): return
	if(body is Ball or body is Player):
		rotation += .8
