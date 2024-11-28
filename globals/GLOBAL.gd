extends Node
signal can_execute
signal clean_cards_effect
signal on_reduce_energy
signal try_to_use_card

const GOALS_TO_WIN = 1
const GAME_TIME_LIMIT = 5 #minutes
const INIT_ENERGY = 15

var is_time_mode = true

var current_player_turn = 1
var current_player_energy := INIT_ENERGY
var player_1_goals = 0
var player_2_goals = 0

var is_waiting_action = false
var rounds_count = 0

func next_player_turn():
	if(rounds_count != 1):
		set_player_turn()
		can_execute.emit(false)
		show_end_turn_view()
		rounds_count += 1
	else:
		can_execute.emit(true)
	set_player_energy()

func set_player_turn():
	if(current_player_turn == 1):
		current_player_turn = 2
	else:
		current_player_turn = 1

func show_end_turn_view():
	var popup_scene = preload("res://Views/finished_turn/finished_turn.tscn")
	var popup_instance = popup_scene.instantiate()
	add_child(popup_instance)
	if(rounds_count == 1):
		clean_cards_effect.emit(true)
		rounds_count = 0
	else:
		clean_cards_effect.emit(false)


func set_player_energy():
	current_player_energy = INIT_ENERGY
	on_reduce_energy.emit(INIT_ENERGY)

func any_winner() -> bool:
	if(is_time_mode): return false
	return player_1_goals >= GOALS_TO_WIN or player_2_goals >= GOALS_TO_WIN
	
func reset_values():
	player_1_goals = 0
	player_2_goals = 0
	current_player_turn = 1

func can_use_card(card: Card_template) -> bool: 
	var can = card.energy_cost <= current_player_energy
	return can

func reduce_energy(card: Card_template):
	if(current_player_energy >= card.energy_cost):
		current_player_energy -= card.energy_cost
		on_reduce_energy.emit(current_player_energy)
	else:
		push_error("Algo fallo con la validacion de energia")
