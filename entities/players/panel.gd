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

	if card.use_in_rival and Global.current_player_turn != player.userOwner\
	or !card.use_in_rival and Global.current_player_turn == player.userOwner:
		on_cart_used.emit(card)
		Deck.use_and_discard_card(card)
		Global.reduce_energy(card)
	else:
		card.change_card_visibility(1) #La retorna al mazo
