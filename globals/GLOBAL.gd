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

var clean_timer: Timer
var disaable_timer: Timer

var finished_turn_scene = load("res://Views/finished_turn/finished_turn.tscn")

func _ready() -> void:
	init_clean_timer()

func init_clean_timer():
	clean_timer = Timer.new()
	add_child(clean_timer)
	clean_timer.one_shot = true
	clean_timer.wait_time = 2.5
	clean_timer.connect("timeout", on_clean_timeout)

func init_disableActions_timer():
	disaable_timer = Timer.new()
	add_child(disaable_timer)
	disaable_timer.one_shot = true
	disaable_timer.wait_time = 2.5
	disaable_timer.connect("timeout", on_clean_timeout)
	
func on_clean_timeout():
	clean_cards_effect.emit(true)

func next_player_turn():
	if(current_player_turn == 1): 
		current_player_turn = 2
		can_execute.emit(false)
		clean_cards_effect.emit(false)
		set_player_energy()
	elif(current_player_turn == 2):
		current_player_turn = 1
		can_execute.emit(true)
		clean_timer.start()
		set_player_energy()
		
		#Aca llamar a las pantallas de entre turnos
		#Validar el can_execute en los jugadores y la pelota, y cuando ya ninguno se mueva mas,
		#ahi recien mostrar la pantalla de vuelta del jugadro 1


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
