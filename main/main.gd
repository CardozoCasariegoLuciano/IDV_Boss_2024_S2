extends Node

@export var players: PackedScene
@export var ball: PackedScene

@onready var cartas: Node2D = $cartas

@onready var label_current_player: Label = $HUD/Turns/Label2
@onready var player_1_goals: Label = $HUD/Goals/player_1_goals
@onready var player_2_goals: Label = $HUD/Goals/player_2_goals

@onready var jugadores: Node2D = $Jugadores
@onready var initial_positions: Node = $initial_positions

const CANT_CARTS = 7

func _ready() -> void:
	start_game(false)

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

func create_cart(index: int):
		var newCart: Card_template = random_card_scene()
		cartas.add_child.call_deferred(newCart)
		
		var path_follow_2d: PathFollow2D = $CartsConfig/CreationCartPath/PathFollow2D
		path_follow_2d.progress = 80 * index
		newCart.global_position = path_follow_2d.global_position
		
func generate_ball():
	var new_ball: Ball = ball.instantiate()
	new_ball.global_position = Vector2(581,273)
	call_deferred("add_child", new_ball)

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

func _on_arco_2_goal(body: Node2D) -> void:
	if body is Ball:
		Global.player_1_goals +=1
		player_1_goals.text = str(Global.player_1_goals)
		call_deferred("remove_child", body)
		start_game(true)

func _on_arco_1_goal(body: Node2D) -> void:
	if body is Ball:
		Global.player_2_goals +=1
		player_2_goals.text = str(Global.player_2_goals)
		call_deferred("remove_child", body)
		start_game(true)

func start_game(clean_old: bool):
	if(Global.any_winner()):
		get_tree().call_deferred("change_scene_to_file","res://Views/win_screen/win_screen.tscn")
		return
	
	if(clean_old):
		for value in jugadores.get_children():
			value.queue_free()
		for value in cartas.get_children():
			value.queue_free()
	generate_players()
	generate_carts()
	generate_ball()
	label_current_player.text = str(Global.current_player_turn)
