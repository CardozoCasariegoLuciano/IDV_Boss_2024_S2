extends Card_template

func _ready() -> void:
	power = 10000
	require_click = true
	energy_cost = 5

func apply_action():
	var player = card_target as Player
	var impuse = (click_point - player.global_position).normalized() * power
	player.apply_central_impulse(impuse)
