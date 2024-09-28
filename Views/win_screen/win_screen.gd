extends CanvasLayer

@onready var final_score: Label = $VBoxContainer/final_score
@onready var winer_laber: Label = $VBoxContainer/winer_laber

func _ready() -> void:
	if(Global.player_1_goals > Global.player_2_goals):
		winer_laber.text = "Gano el jugador 1"
		final_score.text = str(Global.player_1_goals) + " - " + str(Global.player_2_goals)
	else:
		winer_laber.text = "Gano el jugador 2"
		final_score.text = str(Global.player_2_goals) + " - " + str(Global.player_1_goals)

func _on_new_game() -> void:
	Global.reset_values()
	get_tree().change_scene_to_file("res://main/main.tscn")

func _on_exit() -> void:
	get_tree().quit()
