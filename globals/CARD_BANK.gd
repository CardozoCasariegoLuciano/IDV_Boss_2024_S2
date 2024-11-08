extends Node

var card_scenes_bank: Array[CardData] = [
	CardData.new().set_values(
		preload("res://entities/carts/movements/move_card/move_card.tscn"),
		25,25,25,5),
	CardData.new().set_values(
		preload("res://entities/carts/powers/gigant/gigant_card.tscn"),
		5,5,5,10),
	CardData.new().set_values(
		preload("res://entities/carts/powers/wall/wall_card.tscn"),
		1,1,1,1),
	CardData.new().set_values(
		preload("res://entities/carts/movements/move_card_plus/move_card_plus.tscn"),
		5,5,3,1)
]
