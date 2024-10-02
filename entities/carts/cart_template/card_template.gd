extends Node2D
class_name Card_template

#TODO mejoras en el diseño de la carta:
# que el nombre de la carta este mas arriba para poder verlo sin tener que hacerle hover

signal on_cart_used
@onready var card_sprite: Sprite2D = $Sprite2D

var require_click = true
var use_in_rival = false
var power
var max_distance

var player: Player
var click_point: Vector2

func set_data(player_: Player,point: Vector2):
	self.player = player_
	self.click_point = point
	
func change_card_visibility(value: bool):
	card_sprite.visible = value
	
func use_card():
	on_cart_used.emit()

func apply_action():
	pass
