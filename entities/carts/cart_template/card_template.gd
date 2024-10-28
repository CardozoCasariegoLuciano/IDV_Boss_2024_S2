extends Node2D
class_name Card_template

#TODO_2 mejoras en el diseño de la carta:
# que el nombre de la carta este mas arriba para poder verlo sin tener que hacerle hover

@onready var panel: Panel = $Panel
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var card_sprite: Sprite2D = $Sprite2D
@onready var button: Button = $CanvasLayer/Button
@onready var card_sfx: AudioStreamPlayer = $CardSfx

@export var take_card_sfx: AudioStream
@export var card_played_sfx: AudioStream

var scene_path

var require_click = true
var use_in_rival = false
var use_in_field = false
var can_concatenate = false

var energy_cost = 0
var power

var card_target: Node
var click_value: Vector2

func set_target(target: Node):
	_play_sfx(card_played_sfx)
	self.card_target = target
	after_set_data()

func set_data_click(target: Node,point: Vector2):
	_play_sfx(card_played_sfx)
	self.card_target = target
	self.click_value = point
	after_set_data()

func change_card_visibility(value: bool):
	_play_sfx(take_card_sfx)
	card_sprite.visible = value

func apply_action():
	pass
	
func clean_target():
	pass
	
func after_turn():
	pass
	
func after_set_data():
	pass

func _on_discard_card() -> void:
	Deck.use_and_discard_card(self)
	change_card_visibility(false)
	canvas_layer.visible = false
	
func disble_hover():
	button.visible = false
	panel.can_hover = false
	panel.size.y = 1050

func _play_sfx(sound: AudioStream):
	card_sfx.stream = sound
	card_sfx.play()
