extends Node
signal on_change_quantity

const CANT_CARTS = 7
const MAX_DECK_SIZE = 50
const MIN_DECK_SIZE = 30

var player_1_deck: Array[PackedScene] 
var player_1_discard_deck: Array[Card_template]
var player_1_hand: Array[Card_template]
var player_2_deck: Array[PackedScene]
var player_2_discard_deck: Array[Card_template]
var player_2_hand: Array[Card_template]


func set_players_Decks():
	for card_ in CardBank.card_scenes_bank:
		var card = card_ as CardData
		for cant in range(card.player_1_quantity):
			player_1_deck.append(card.scene)
		for cant in range(card.player_2_quantity):
			player_2_deck.append(card.scene)
			
	player_1_deck.shuffle()
	player_2_deck.shuffle()

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
	player_1_deck = []
	player_1_discard_deck = []
	player_1_hand= []
	player_2_deck = []
	player_2_discard_deck= []
	player_2_hand = []
	set_players_Decks()
