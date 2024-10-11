extends Node
signal on_change_quantity

#TODO que no sea solo un array, sino un objeto y tenga:
#El preload
#La cantidad default de cartas
#El Step a la hora de seleccionar
#La cantidad seleccionada hasta ahora del player 1
#La cantidad seleccionada hasta ahora del player 2
var card_scenes_bank = [
	preload("res://entities/carts/movements/move_card/move_card.tscn"),
	preload("res://entities/carts/powers/gigant/gigant_card.tscn"),
	preload("res://entities/carts/powers/wall/wall_card.tscn"),
]

const CANT_CARTS = 7
const MAX_DECK_SIZE = 50

var player_1_deck: Array[PackedScene] = generate_default_deck()
var player_1_discard_deck: Array[Card_template]
var player_1_hand: Array[Card_template]
var player_2_deck: Array[PackedScene] = generate_default_deck()
var player_2_discard_deck: Array[Card_template]
var player_2_hand: Array[Card_template]


func generate_default_deck() -> Array[PackedScene]:
	var deck: Array[PackedScene] = []
	
	for _card in range(10):
		var card = preload("res://entities/carts/movements/move_card/move_card.tscn")
		deck.append(card)
	for _card in range(1):
		var card = preload("res://entities/carts/powers/gigant/gigant_card.tscn")
		deck.append(card)
	for _card in range(1):
		var card = preload("res://entities/carts/powers/wall/wall_card.tscn")
		deck.append(card)
	
	deck.shuffle()
	return deck
	
func fill_current_player_hand():
	while get_current_player_hand().size() < CANT_CARTS:
		if(get_current_player_Deck().is_empty()):
			var cards_scenes = get_current_player_DiscardDeck().map(func(element:Card_template): return element.scene_path)
			cards_scenes.shuffle()
			get_current_player_Deck().append_array(cards_scenes)
			get_current_player_DiscardDeck().clear()
		var a = get_current_player_Deck().pop_front() as PackedScene
		get_current_player_hand().append(a.instantiate())
	on_change_quantity.emit()

func use_and_discard_card(card: Card_template):
	get_current_player_hand().erase(card)
	get_current_player_DiscardDeck().append(card)
	on_change_quantity.emit()

func get_current_player_Deck():
	if(Global.current_player_turn == 1):
		return player_1_deck
	else:
		return player_2_deck
		
func get_current_player_DiscardDeck():
	if(Global.current_player_turn == 1):
		return player_1_discard_deck
	else:
		return player_2_discard_deck

func get_current_player_hand():
	if(Global.current_player_turn == 1):
		return player_1_hand
	else:
		return player_2_hand
		
func reset_values():
	player_1_deck = generate_default_deck()
	player_1_discard_deck = []
	player_1_hand= []
	player_2_deck = generate_default_deck()
	player_2_discard_deck= []
	player_2_hand = []
