extends Card_template

func _ready() -> void:
	power = 10000
	require_click = true


func apply_action():
	player.apply_central_impulse(point * power)
