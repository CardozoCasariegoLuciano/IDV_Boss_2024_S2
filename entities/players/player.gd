extends RigidBody2D
class_name Player

@onready var selected: Sprite2D = $selected
@onready var arrow_direction: Sprite2D = $player_direction

var enable_click := false
var used_cards: Array[Card_template]

var userOwner

func initialize(marker: Marker2D, userOwner_id: int):
	self.userOwner = userOwner_id
	global_position = marker.global_position
	if userOwner == 2:
		modulate = "ff41ff"

func _ready() -> void:
	initial_properties()
	Global.can_execute.connect(execute_move)
	Global.clean_cards_effect.connect(clean_player)

func execute_move(can_execute: bool):
	if(can_execute and !used_cards.is_empty()):
		for card in used_cards:
			card.apply_action()
	if(!can_execute and !used_cards.is_empty()):
		for card in used_cards:
			card.after_turn()

func _on_panel_on_cart_used(data: Card_template) -> void:
	if(data.use_in_field):
		data.change_card_visibility(1)
		return
	if(!used_cards.is_empty() and used_cards[-1].can_concatenate):
		used_cards.append(data)
	else:
		used_cards = [data]
	data.set_target(self)
	enable_click = data.require_click

func initial_properties():
	contact_monitor = true
	max_contacts_reported = 5
	gravity_scale = 0
	scale = Vector2(1,1)
	mass = 20
	linear_damp = 1.0
	angular_damp = 100.0
	if userOwner == 1:
		modulate = Color(1,1,1,1)
	else:
		modulate = "ff41ff"

func clean_player(can_clean: bool) -> void:
	if(can_clean): 
		for card in used_cards:
			card.clean_target()
		used_cards.clear()
