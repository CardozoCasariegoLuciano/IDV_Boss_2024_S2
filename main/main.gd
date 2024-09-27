extends Node

@export var players: PackedScene

@onready var cartas: Node = $cartas
@onready var label_current_player: Label = $CanvasLayer/HBoxContainer/Label2

@onready var jugadores: Node = $Jugadores
@onready var initial_positions: Node = $initial_positions


const CANT_CARTS = 7

func _ready() -> void:
	generate_players()
	generate_carts()
	label_current_player.text = str(Global.current_player_turn)

func generate_players():
	var player = 1
	for value in initial_positions.get_children():
		create_player(value, player)
		player = 2

func create_player(value: Node, player: int):
	for positions in value.get_children():
		var newPlayer: Player = players.instantiate()
		jugadores.add_child.call_deferred(newPlayer)
		newPlayer.initialize(positions, player)


func generate_carts():
	for i in range(CANT_CARTS):
		create_cart(i)
	Global.can_execute.emit(false)


func create_cart(index: int):
		var newCart: Card_template = random_card_scene()
		cartas.add_child.call_deferred(newCart)
		
		var path_follow_2d: PathFollow2D = $CartsConfig/CreationCartPath/PathFollow2D
		path_follow_2d.progress = 80 * index
		newCart.global_position = path_follow_2d.global_position


func random_card_scene() -> Card_template:
	var random_index = randi() % CardBank.card_scenes_bank.size()
	return CardBank.card_scenes_bank[random_index].instantiate()


func _on_end_turn() -> void:
	Global.next_player_turn()
	label_current_player.text = str(Global.current_player_turn)
	next_player_turn()

	
func next_player_turn():
	for card in cartas.get_children():
		cartas.remove_child(card)
	generate_carts()
