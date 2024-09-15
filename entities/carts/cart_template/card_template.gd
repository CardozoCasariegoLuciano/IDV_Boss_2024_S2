extends Node
class_name Card_template

signal on_cart_used
@onready var color_rect: ColorRect = $ColorRect

var require_click = true
var power
var max_distance

var player: Player
var click_point: Vector2

func set_data(player: Player,point: Vector2):
	self.player = player
	self.click_point = point
	
func change_card_visibility(value: int):
	color_rect.color.a = value
	
func use_card():
	on_cart_used.emit()

func apply_action():
	pass
	
	
