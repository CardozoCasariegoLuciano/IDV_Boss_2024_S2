extends Panel
signal on_cart_used

@onready var player: Player = $".."

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var card: Card_template = data
		
	if card.use_in_rival and Global.current_player_turn != player.userOwner\
	or !card.use_in_rival and Global.current_player_turn == player.userOwner:
		on_cart_used.emit(card)
	else:
		card.change_card_visibility(1) #La retorna al mazo
