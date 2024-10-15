extends CanvasLayer
@export var deck_selector: PackedScene
@export var formation_selector: PackedScene


func _on_start_game() -> void:
	get_tree().change_scene_to_file("res://main/main.tscn")

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
