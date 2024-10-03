extends Card_template

@export var wall_scene: PackedScene

func _ready() -> void:
	require_click = true
	can_concatenate = true

func apply_action():
	player.mass = 300
	player.modulate = Color(.3,.3,.3,1)

func clean_player():
	player.initial_properties()
