extends Node
signal can_execute
signal clean_cards_effect
signal on_reduce_energy
signal try_to_use_card

const GOALS_TO_WIN = 2
const INIT_ENERGY = 15

var current_player_turn = 1
var current_player_energy := INIT_ENERGY
var player_1_goals = 0
var player_2_goals = 0

var is_waiting_action = false

func next_player_turn():
	if(current_player_turn == 1): 
		current_player_turn = 2
		can_execute.emit(false)
		show_end_turn_view()
	elif(current_player_turn == 2):
		current_player_turn = 1
		can_execute.emit(true)
	set_player_energy()

func show_end_turn_view():
	clean_cards_effect.emit(current_player_turn == 1)

func set_player_energy():
	current_player_energy = INIT_ENERGY
	on_reduce_energy.emit(INIT_ENERGY)

func any_winner() -> bool:
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
