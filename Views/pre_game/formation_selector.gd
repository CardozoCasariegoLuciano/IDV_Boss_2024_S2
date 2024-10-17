extends Control

@onready var title: Label = $Label
@onready var options: Node2D = $options

var player: int

func init_formation_selection(playerID: int):
	self.player =  playerID
	title.text = "Formacion del jugador: " + str(player)
	generate_options()
	select_current_formation()

func generate_options():
	var formations_scenes = Formations.formations_bank 
	var op_position = 270 if(player == 2) else 50

	for formation_scene in formations_scenes:
		var formation_instance = formation_scene.instantiate() as Formation_template
		options.add_child(formation_instance)
		
		if(player == 2):
			formation_instance.set_formation_to_player_2()

		formation_instance.position.x = op_position
		op_position += 270
		formation_instance.position.y += -100
		
		formation_instance.scale = Vector2(0.2, 0.2)
		formation_instance.scene = formation_scene
		formation_instance.get_on_click_signal().connect(on_select_formation)
		formation_instance.set_reference_visible(true)
		formation_instance.fill_marcks_width_points()

func select_current_formation():
	var current
	if(player == 1): current = Formations.players_formations[0]
	else: current = Formations.players_formations[1]
	
	for formation_ in options.get_children():
		var formation = formation_ as Formation_template
		if(formation.scene == current):
			formation.set_selected_line_visible(true)

func _on_close() -> void:
	queue_free()
	
func on_select_formation(selected: Formation_template):
	for formation_ in options.get_children():
		var formation = formation_ as Formation_template
		formation.set_selected_line_visible(false)
	selected.set_selected_line_visible(true)
	if(player == 1):
		Formations.players_formations[0] = selected.scene
	else:
		Formations.players_formations[1] = selected.scene

	
