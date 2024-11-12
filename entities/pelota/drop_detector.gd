extends Panel

var timer: Timer

func _ready() -> void:
	init_timer()
	
func init_timer():
	timer = Timer.new()
	timer.wait_time = 1 
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", on_timer_timeout)
	
func on_timer_timeout():
	visible = true

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if(data is Wall_card):
		data.change_card_visibility(true)
		return false
	else:
		visible = false
		timer.start()
		return true
