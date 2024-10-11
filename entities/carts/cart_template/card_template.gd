extends Node2D
class_name Card_template

#TODO_2 mejoras en el diseño de la carta:
# que el nombre de la carta este mas arriba para poder verlo sin tener que hacerle hover

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var card_sprite: Sprite2D = $Sprite2D
var scene_path

var require_click = true
var use_in_rival = false
var use_in_field = false
var can_concatenate = false

var energy_cost = 0
var power

var card_target: Node
var click_point: Vector2

func set_data(target: Node,point: Vector2):
	self.card_target = target
	self.click_point = point
	after_set_data()


func change_card_visibility(value: bool):
	card_sprite.visible = value

func apply_action():
	pass
	
func clean_target():
	pass
	
func after_set_data():
	pass

func _on_discard_card() -> void:
	CardBank.use_and_discard_card(self)
	change_card_visibility(false)
	canvas_layer.visible = false
