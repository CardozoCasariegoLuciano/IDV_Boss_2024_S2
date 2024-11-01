extends Card_template

func _ready() -> void:
	scene_path = preload("res://entities/carts/powers/gigant/gigant_card.tscn")
	require_click = false
	energy_cost = 8

func apply_action():
	var player = card_target as Player
	player.mass = 300
	player.modulate = Color(.3,.3,.3,1)

func after_turn():
	var player = card_target as Player
	player.initial_properties()
	player.sprite_2d.modulate = Color(1,1,1,1)
	
func after_set_data():
	var player = card_target as Player
	player.sprite_2d.modulate = Color(.3,.3,.3,1)

func clean_target():
	var player = card_target as Player
	player.initial_properties()
	player.sprite_2d.modulate = Color(1,1,1,1)
