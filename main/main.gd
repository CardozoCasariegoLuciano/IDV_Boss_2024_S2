extends Node

@export var ball: PackedScene

@onready var players_section: Node2D = $players_section
@onready var cards_section: Node2D = $cards_section
@onready var cancha: Node = $cancha

@onready var main_sfx: AudioStreamPlayer = $MainSfx
@onready var croud_sfx: AudioStreamPlayer = $CroudSfx
@export var whistle_sound: AudioStream
@export var croud_sound: AudioStreamOggVorbis
@export var finished_turn_sound: AudioStream

func _ready() -> void:
	Deck.set_players_Decks()
	_play_croud_sound()
	start_game(false);
	cancha.on_goal.connect(func(): start_game(true))

func generate_ball():
	var new_ball: Ball = ball.instantiate()
	new_ball.global_position = Vector2(581,273)
	call_deferred("add_child", new_ball)

func _on_end_turn() -> void:
	_play_sound(finished_turn_sound)
	Global.next_player_turn()
	cards_section.clean_cards()
	cards_section.generate_carts()

func start_game(clean_old: bool):
	_play_sound(whistle_sound)
	if(Global.any_winner()):
		get_tree().call_deferred("change_scene_to_file","res://Views/win_screen/win_screen.tscn")
		return
		
	if(clean_old):
		for value in players_section.get_players():
			value.queue_free()
		for value in cards_section.get_cards():
			value.queue_free()
	Deck.reset_values()
	players_section.generate_players()
	cards_section.generate_carts()
	generate_ball()

func _play_sound(sound: AudioStream):
	main_sfx.stream = sound
	main_sfx.play()

func _play_croud_sound():
	croud_sfx.volume_db = -35
	croud_sfx.stream = croud_sound
	croud_sfx.play()
