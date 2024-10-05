extends Panel
@onready var main: Node = $"../.."

var enable_click := false
var used_cards: Array[Card_template]

func _ready() -> void:
	Global.clean_cards_effect.connect(clean_card_effects)

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	var card = data as Card_template
	var can_use = Global.can_use_car(card)
	if(!can_use):
		card.change_card_visibility(true)
	return can_use
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var card = data as Card_template
	Global.reduce_energy(card)
	
	if(card.use_in_field):
		used_cards.append(card)
		enable_click = card.require_click
	else:
		data.change_card_visibility(1)

func _input(event):
	if(!enable_click): return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var last_card = used_cards[-1]
			last_card.set_data(main, event.position)
			enable_click = false

func clean_card_effects(can_clean: bool):
	if(!can_clean): return
	for card in used_cards:
		card.clean_target()
	used_cards.clear()
	
