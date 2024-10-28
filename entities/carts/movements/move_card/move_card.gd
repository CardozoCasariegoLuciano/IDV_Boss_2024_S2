extends Card_template

var click_init_value
var click_last_value
var player: Player
var max_range_value = 100

func _ready() -> void:
	scene_path = preload("res://entities/carts/movements/move_card/move_card.tscn")
	power = 8000
	require_click = true
	energy_cost = 5

func _physics_process(delta: float) -> void:
	if(!player): return
	player.selected.rotation += 8.0 * delta
	if(click_init_value):
		var angle = ( click_init_value - get_global_mouse_position()).angle()
		player.set_deferred("rotation", angle)
		
		var distance = clamp(click_init_value.distance_to(get_global_mouse_position()), 0, max_range_value)
		var color_factor = distance / max_range_value
		var color = Color(1, 1 - color_factor, 1 - color_factor)
		player.arrow_direction.modulate = color

func _input(event):
	if(!player): return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT  and event.pressed:
			click_init_value = event.position
			player.arrow_direction.visible = true
			player.arrow_direction.modulate = Color.WHITE
		if event.button_index == MOUSE_BUTTON_LEFT  and !event.pressed:
			click_last_value =  event.position
			player.selected.visible = false
			player = null
			
func after_turn():
	if(!card_target): return
	card_target.arrow_direction.visible = false

func after_set_data():
	if(!card_target): return
	self.player = card_target
	card_target.selected.visible = true

func apply_action():
	var execute_player = card_target as Player
	execute_player.arrow_direction.visible = false
	var distance_selected = click_init_value.distance_to(click_last_value) / max_range_value
	var impulse = (click_init_value - click_last_value).normalized() * power * clamp(distance_selected, 0.1, 1)
	execute_player.apply_central_impulse(impulse)
