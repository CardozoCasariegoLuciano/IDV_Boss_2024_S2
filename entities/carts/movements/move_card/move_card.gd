extends Card_template

func _ready() -> void:
	power = 10000
	require_click = true

func apply_action():
	var impuse = (click_point - player.global_position).normalized() * power
	player.apply_central_impulse(impuse)
