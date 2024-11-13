extends Panel
signal on_cart_used

@onready var player: Player = $".."

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	var card = data as Card_template
	var can_use = Global.can_use_card(card)
	if(!can_use):
		card.change_card_visibility(true)
	return can_use

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var card = data as Card_template

	if is_owner_player(data) and !card.use_in_field and !already_used_card(card):
		on_cart_used.emit(card)
		Deck.use_and_discard_card(card)
		Global.reduce_energy(card)
	else:
		card.change_card_visibility(true) #La retorna al mazo

	
func already_used_card(card: Card_template) -> bool:
	if(!card.is_movement_card):
		return false
	else:
		return player.used_cards.any(func(used_card: Card_template): return used_card.is_movement_card)
	
func is_owner_player(card: Card_template) -> bool:
	return !card.use_in_rival and Global.current_player_turn == player.userOwner
