extends Node

@export var players: PackedScene
@export var ball: PackedScene

@onready var cartas: Node2D = $cartas

@onready var label_current_player: Label = $HUD/Turns/Label2
@onready var player_1_goals: Label = $HUD/Goals/player_1_goals
@onready var player_2_goals: Label = $HUD/Goals/player_2_goals

@onready var jugadores: Node2D = $Jugadores
@onready var initial_positions: Node = $initial_positions

@onready var main_sfx: AudioStreamPlayer = $MainSfx
@onready var goal_sfx: AudioStreamPlayer = $GoalSfx
@onready var croud_sfx: AudioStreamPlayer = $CroudSfx

@export var whistle_sound: AudioStream
@export var goal_sound: AudioStream
@export var croud_sound: AudioStream

func _ready() -> void:
	Deck.set_players_Decks()
	_play_croud_sound()
	start_game(false);

func generate_players():
	for player in range(1,3):
		var formation_scene = Formations.players_formations[player - 1]
		var formation = (formation_scene as PackedScene).instantiate() as Formation_template
		initial_positions.add_child(formation)
		formation.hide_panel()
		formation.position = Vector2(40, 290)
		if(player == 2):
			formation.set_formation_to_player_2()
		create_players(formation, player)

func create_players(value: Formation_template, player: int):
	for positions in value.get_markers():
		var newPlayer: Player = players.instantiate()
		jugadores.add_child.call_deferred(newPlayer)
		newPlayer.initialize(positions, player)

func generate_carts():
	Deck.fill_current_player_hand()
	var generated_cards = 0
	for card in Deck.get_current_player_hand():
		add_card(card, generated_cards)
		generated_cards += 1

func add_card(card: Card_template, index: int):
	cartas.add_child.call_deferred(card)
	var path_follow_2d: PathFollow2D = $CartsConfig/CreationCartPath/PathFollow2D
	path_follow_2d.progress = 80 * index
	card.global_position = path_follow_2d.global_position

func generate_ball():
	var new_ball: Ball = ball.instantiate()
	new_ball.global_position = Vector2(581,273)
	call_deferred("add_child", new_ball)

func _on_end_turn() -> void:
	Global.next_player_turn()
	label_current_player.text = str(Global.current_player_turn)
	next_player_turn()

func next_player_turn():
	for card in cartas.get_children():
		cartas.remove_child(card)
	generate_carts()

#TODO refactor mover este metodo a otro lado (hace ruido que este en main)
func _on_arco_2_goal(body: Node2D) -> void:
	if body is Ball:
		_play_goal_sound()
		Global.player_1_goals +=1
		player_1_goals.text = str(Global.player_1_goals)
		call_deferred("remove_child", body)
		start_game(true)
		
#TODO refactor mover este metodo a otro lado (hace ruido que este en main)
func _on_arco_1_goal(body: Node2D) -> void:
	if body is Ball:
		_play_goal_sound()
		Global.player_2_goals +=1
		player_2_goals.text = str(Global.player_2_goals)
		call_deferred("remove_child", body)
		start_game(true)

func start_game(clean_old: bool):
	_play_sound(whistle_sound)
	if(Global.any_winner()):
		get_tree().call_deferred("change_scene_to_file","res://Views/win_screen/win_screen.tscn")
		return
		
	if(clean_old):
		for value in jugadores.get_children():
			value.queue_free()
		for value in cartas.get_children():
			value.queue_free()
	Deck.reset_values()
	generate_players()
	generate_carts()
	generate_ball()
	
	label_current_player.text = str(Global.current_player_turn)

func _play_sound(sound: AudioStream):
	main_sfx.stream = sound
	main_sfx.play()
	
func _play_goal_sound():
	goal_sfx.stream = goal_sound
	goal_sfx.play()

func _play_croud_sound():
	croud_sfx.volume_db = -60
	croud_sfx.stream = croud_sound
	croud_sfx.play()
