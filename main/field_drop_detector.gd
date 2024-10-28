extends Panel
@onready var main: Node = $"../.."

var enable_click := false
var used_cards: Array[Card_template]

func _ready() -> void:
	Global.clean_cards_effect.connect(clean_card_effects)
	Global.can_execute.connect(execute_move)

func execute_move(can_execute: bool):
	if(can_execute and !used_cards.is_empty()):
		for card in used_cards:
			card.apply_action()
	if(!can_execute and !used_cards.is_empty()):
		for card in used_cards:
			card.after_turn()

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	var card = data as Card_template
	var can_use = Global.can_use_card(card)
	if(!can_use):
		card.change_card_visibility(true)
	return can_use
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var card = data as Card_template

	if(card.use_in_field):
		Global.reduce_energy(card)
		used_cards.append(card)
		data.set_target(main)
		Deck.use_and_discard_card(card)
	else:
		data.change_card_visibility(1)

func clean_card_effects(can_clean: bool):
	if(!can_clean): return
	for card in used_cards:
		card.clean_target()
	used_cards.clear()
	
