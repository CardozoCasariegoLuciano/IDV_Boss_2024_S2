extends Node2D
class_name Card_option
signal on_update_option_quantity

@onready var marker_2d: Marker2D = $Marker2D
@onready var label: Label = $HBoxContainer/Label

var card: CardData
var player: int
	
func initialize(card_: CardData, player_: int, current: int):
	card = card_
	player = player_
	label.text = str(current)
	var card_sene = card.scene.instantiate() as Card_template
	add_child(card_sene)
	card_sene.disble_hover()
	card_sene.position = marker_2d.position

func _on_add_cards() -> void:
	if(player == 1):
		card.player_1_quantity += card.step_quantity
		label.text = str(card.player_1_quantity)
	if(player == 2):
		card.player_2_quantity += card.step_quantity
		label.text = str(card.player_2_quantity)
	on_update_option_quantity.emit()


func _on_remove_cards() -> void:
	if(player == 1 and card.player_1_quantity > 0):
		if(card.player_1_quantity - card.step_quantity > 0):
			card.player_1_quantity -= card.step_quantity
		else:
			card.player_1_quantity = 0
		label.text = str(card.player_1_quantity)
	if(player == 2 and card.player_2_quantity > 0):
		if(card.player_2_quantity - card.step_quantity > 0):
			card.player_2_quantity -= card.step_quantity
		else:
			card.player_2_quantity = 0
		label.text = str(card.player_2_quantity)
	on_update_option_quantity.emit()
	
func update_quantity():
	if(player == 1 ):
		label.text = str(card.player_1_quantity)
	if(player == 2 ):
		label.text = str(card.player_2_quantity)
