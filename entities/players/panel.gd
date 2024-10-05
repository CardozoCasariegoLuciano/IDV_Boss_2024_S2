extends Panel
signal on_cart_used

@onready var player: Player = $".."

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	var card = data as Card_template
	var can_use = Global.can_use_car(card)
	if(!can_use):
		card.change_card_visibility(true)
	return can_use

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var card = data as Card_template
	Global.reduce_energy(card)

	if card.use_in_rival and Global.current_player_turn != player.userOwner\
	or !card.use_in_rival and Global.current_player_turn == player.userOwner:
		on_cart_used.emit(card)
	else:
		card.change_card_visibility(1) #La retorna al mazo
