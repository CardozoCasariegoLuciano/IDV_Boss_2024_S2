extends Node2D

@export var players: PackedScene
@onready var initial_positions: Node = $initial_positions
@onready var players_instances: Node2D = $players_instances

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
