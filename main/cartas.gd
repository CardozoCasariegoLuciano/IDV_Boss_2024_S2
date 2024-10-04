extends Node2D

func _ready() -> void:
	Global.can_execute.connect(disable_button)
	Global.clean_cards_effect.connect(enable_button)
	
func disable_button(can_execute: bool):
	if(can_execute):
		visible = false

func enable_button(can_clean: bool):
	if(can_clean):
		visible = true
