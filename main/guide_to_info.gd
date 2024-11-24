extends Panel

var timer: Timer
@onready var color_rect: Panel = $Panel

var flag = true

func _process(delta: float) -> void:
	if(flag):
		color_rect.modulate.a += 0.03
		flag = !color_rect.modulate.a >= 1
	else:
		color_rect.modulate.a -= 0.03
		flag = color_rect.modulate.a <= 0

func _ready() -> void:
	init_timer()
	timer.start()

func init_timer():
	timer = Timer.new()
	timer.wait_time = 4 
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", on_timer_timeout)
	
func on_timer_timeout():
	queue_free()
