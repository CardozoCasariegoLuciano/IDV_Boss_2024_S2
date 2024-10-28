extends Node2D

@onready var path_follow_2d: PathFollow2D = $CartsConfig/CreationCartPath/PathFollow2D
@onready var cards_intances: Node2D = $cards_intances

func _ready() -> void:
	Global.can_execute.connect(disable_button)
	Global.clean_cards_effect.connect(enable_button)

func generate_carts():
	Deck.fill_current_player_hand()
	var generated_cards = 0
	for card in Deck.get_current_player_hand():
		add_card(card, generated_cards)
		generated_cards += 1

func add_card(card: Card_template, index: int):
	cards_intances.add_child.call_deferred(card)
	path_follow_2d.progress = 80 * index
	card.global_position = path_follow_2d.global_position

func get_cards():
	return cards_intances.get_children()

func clean_cards():
	for card in get_cards():
		cards_intances.remove_child(card)

func disable_button(can_execute: bool):
	if(can_execute):
		visible = false

func enable_button(can_clean: bool):
	if(can_clean):
		visible = true
