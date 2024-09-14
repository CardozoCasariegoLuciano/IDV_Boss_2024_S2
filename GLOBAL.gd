extends Node
signal can_execute
#var can_execute = false

var current_player_turn = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Funcaaa")


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
