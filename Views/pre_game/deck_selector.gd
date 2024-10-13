extends Control

@onready var title: Label = $Label
@onready var options: Node2D = $options
@onready var total_quantity: Label = $total_quantity

var player: int
var total_cards: int

func _on_confirm() -> void:
	if(total_cards <= Deck.MAX_DECK_SIZE and total_cards >= Deck.MIN_DECK_SIZE):
		queue_free()

func init_deck_selection(playerID: int):
	self.player =  playerID
	title.text = "Mazo del jugador: " + str(player)
	generate_options()
	total_quantity.text = "Cartas totales: 0"
	update_quantity()

func generate_options():
	var card_options: Array[CardData] = CardBank.card_scenes_bank 
	var op_position = -160
	for card in card_options:
		var option: Card_option = preload("res://entities/carts/card_options/card_option.tscn").instantiate()
		options.add_child(option)
		var current =  card.player_1_quantity if self.player == 1 else card.player_2_quantity
		option.initialize(card, self.player, current)
		option.position.x =  op_position
		option.position.y += 50
		op_position += 160
		option.connect("on_update_option_quantity", update_quantity)

func update_quantity():
	var card_options: Array[CardData] = CardBank.card_scenes_bank
	total_cards = 0
	for card in card_options:
		if(player == 1):
			total_cards += card.player_1_quantity
		else:
			total_cards += card.player_2_quantity
	total_quantity.text = "Cartas totales: " + str(total_cards)
	if(total_cards > Deck.MAX_DECK_SIZE or total_cards < Deck.MIN_DECK_SIZE):
		total_quantity.modulate = Color.CHOCOLATE
	else:
		total_quantity.modulate = Color.WHITE

func _on_set_default_deck() -> void:
	var card_options: Array[CardData] = CardBank.card_scenes_bank 
	for card in card_options:
		if(player == 1):
			card.player_1_quantity = card.default_quantity
		else:
			card.player_2_quantity = card.default_quantity
	update_quantity()
	for option in options.get_children():
		(option as Card_option).update_quantity()
