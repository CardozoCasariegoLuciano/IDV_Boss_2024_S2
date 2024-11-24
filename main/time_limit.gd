extends Label
signal _on_game_timeout

var timer: Timer
const SECONDS = 60
var time_left = SECONDS * Global.GAME_TIME_LIMIT 

func _ready() -> void:
	if(!Global.is_time_mode):
		visible = false
	else:
		init_timer()
		timer.start()
		text = parse_time(time_left)

func init_timer():
	timer = Timer.new()
	timer.wait_time = 1
	timer.one_shot = false
	add_child(timer)
	timer.connect("timeout", on_timer_timeout)
	
func on_timer_timeout():
	time_left -= 1
	text = parse_time(time_left)
	if(time_left <= 0):
		_on_game_timeout.emit()
		timer.stop()

func parse_time(time) -> String:
	var minutes = time / SECONDS
	var secods = time % SECONDS
	if(secods <= 9):
		secods = "0" + str(secods)
		
	return str(minutes) + ":" + str(secods)
