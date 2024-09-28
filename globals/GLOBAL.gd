extends Node
signal can_execute

const GOALS_TO_WIN = 1

var current_player_turn = 1
var player_1_goals = 0
var player_2_goals = 0

func next_player_turn():
	if(current_player_turn == 1): 
		current_player_turn = 2
		can_execute.emit(false)
	elif(current_player_turn == 2):
		current_player_turn = 1
		can_execute.emit(true)
	else:
		current_player_turn = 1
		can_execute.emit(false)

func any_winner() -> bool:
	return player_1_goals >= GOALS_TO_WIN or player_2_goals >= GOALS_TO_WIN
	
func reset_values():
	player_1_goals = 0
	player_2_goals = 0
	current_player_turn = 1
