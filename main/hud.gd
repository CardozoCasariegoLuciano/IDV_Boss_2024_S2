extends CanvasLayer

@onready var end_turn_button: Button = $EndTurn_Button

func _ready() -> void:
	Global.can_execute.connect(disable_button)
	Global.clean_cards_effect.connect(enable_button)
	
func disable_button(can_execute: bool):
	if(can_execute):
		end_turn_button.disabled = true
	
func enable_button(can_clean: bool):
	if(can_clean):
		end_turn_button.disabled = false
