extends CanvasLayer

@onready var next_turn: Label = $VBoxContainer/turn_label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_turn.text = "Turno del jugador " + str(Global.current_player_turn)


func _on_next_player_button_pressed() -> void:
	queue_free()
