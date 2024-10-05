extends Card_template

func _ready() -> void:
	require_click = false
	can_concatenate = true
	energy_cost = 8

func apply_action():
	var player = card_target as Player
	player.mass = 300
	player.modulate = Color(.3,.3,.3,1)

func clean_target():
	var player = card_target as Player
	player.initial_properties()
