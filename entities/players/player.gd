extends RigidBody2D
class_name Player

@onready var selected: Sprite2D = $selected
@onready var arrow_direction: Sprite2D = $player_direction
@onready var sprite_2d: Sprite2D = $Sprite2D

var enable_click := false
var used_cards: Array[Card_template]

var userOwner
var player_2_texture = preload("res://assets/players/player_2.png")

func initialize(marker: Marker2D, userOwner_id: int):
	self.userOwner = userOwner_id
	global_position = marker.global_position
	
func _ready() -> void:
	initial_properties()
	Global.can_execute.connect(execute_move)
	Global.clean_cards_effect.connect(clean_player)
	if userOwner == 1:
		sprite_2d.texture = PlayerSkins.skin_player_1
	if userOwner == 2:
		sprite_2d.texture = PlayerSkins.skin_player_2
	var desired_size = Vector2(44, 44)  # Tamaño deseado
	var texture_size = sprite_2d.texture.get_size()

	var scale_factor = min(desired_size.x / texture_size.x, desired_size.y / texture_size.y)
	sprite_2d.scale = Vector2(scale_factor, scale_factor)
		
func execute_move(can_execute: bool):
	if(can_execute and !used_cards.is_empty()):
		for card in used_cards:
			card.apply_action()
	if(!can_execute and !used_cards.is_empty()):
		for card in used_cards:
			card.after_turn()

func _on_panel_on_cart_used(data: Card_template) -> void:
	used_cards.append(data)
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
	modulate = Color(1,1,1,1)

func clean_player(can_clean: bool) -> void:
	if(can_clean): 
		for card in used_cards:
			card.clean_target()
		used_cards.clear()
