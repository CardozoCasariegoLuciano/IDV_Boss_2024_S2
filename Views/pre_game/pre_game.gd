extends CanvasLayer
@onready var deck_selector: Control = $"Deck selector"


func _on_start_game() -> void:
	get_tree().change_scene_to_file("res://main/main.tscn")


func _on_player_1_select_deck() -> void:
	deck_selector.init_deck_selection(1)

func _on_player_2_select_deck() -> void:
	deck_selector.init_deck_selection(2)
