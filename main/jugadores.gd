extends Node2D

@export var players: PackedScene
@onready var initial_positions: Node = $initial_positions
@onready var players_instances: Node2D = $players_instances

func _ready() -> void:
	Global.can_execute.connect(watch_player_movements)
	set_process(false)

func _process(_delta: float) -> void:
	if(are_players_stop()):
		set_process(false)
		await get_tree().create_timer(1).timeout
		Global.show_end_turn_view()

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
		players_instances.add_child.call_deferred(newPlayer)
		newPlayer.initialize(positions, player)

func get_players():
	return players_instances.get_children()

func watch_player_movements(can_execute: bool):
	await get_tree().create_timer(1).timeout
	set_process(can_execute)

func are_players_stop():
	var value = true
	for pl in players_instances.get_children():
		value = value and pl.linear_velocity.length() <= Vector2(4,4).length()
	return value
