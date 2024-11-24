extends CanvasLayer
@export var deck_selector: PackedScene
@export var formation_selector: PackedScene
@onready var check_button: CheckButton = $game_mode/HBoxContainer/CheckButton


func _on_start_game() -> void:
	if (PlayerSkins.skin_player_1 != null && PlayerSkins.skin_player_2 != null):
		Global.is_time_mode = check_button.button_pressed
		get_tree().change_scene_to_file("res://main/main.tscn")
	else:
		_show_error_message("Ambos jugadores deben elegir equipo antes de comenzar")

func _show_error_message(message: String) -> void:
	var error_label = $ErrorLabel  # Asegúrate de tener un nodo Label llamado 'ErrorLabel' en tu escena
	error_label.text = message
	error_label.visible = true

func _on_player_1_select_deck() -> void:
	var deck = deck_selector.instantiate()
	add_child(deck)
	deck.init_deck_selection(1)

func _on_player_2_select_deck() -> void:
	var deck = deck_selector.instantiate()
	add_child(deck)
	deck.init_deck_selection(2)

func _on_player_1_select_formation() -> void:
	var formation = formation_selector.instantiate()
	add_child(formation)
	formation.init_formation_selection(1)

func _on_player_2_select_formation() -> void:
	var formation = formation_selector.instantiate()
	add_child(formation)
	formation.init_formation_selection(2)
