extends Node2D
class_name Card_template

@onready var panel: Panel = $Panel
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var card_sprite: Sprite2D = $Card
@onready var button: Button = $CanvasLayer/Button
@onready var card_sfx: AudioStreamPlayer = $CardSfx
@onready var card_taken_sfx: AudioStreamPlayer = $CardTakenSfx

@export var card_played_sfx: AudioStream

var scene_path

var require_click = true
var use_in_rival = false
var use_in_field = false
var is_movement_card = false #Si es true, cada jugador solo podra tener una sola carta de ese tipo

var energy_cost = 0
var power

var card_target: Node
var point_target: Vector2

func set_target(target: Node):
	_play_sfx(card_played_sfx)
	self.card_target = target
	after_set_data()

func set_target_and_point(target: Node, point: Vector2):
	_play_sfx(card_played_sfx)
	self.card_target = target
	self.point_target = point
	after_set_data()

func change_card_visibility(value: bool):
	card_taken_sfx.play()
	card_sprite.visible = value


#Este es el metodo principa, es la accion que hace la carta al momento de ejecutar
#las jugadas de las 2 personas
func apply_action():
	pass

#Este metodo se ejecuta luego de que se disparen las jugadas de las 2 personas
func clean_target():
	pass
	
#Este metodo se ejecuta cuando un juegador termina su turno 
func after_turn():
	pass

#Este metodo se ejecuta luego de asignar la carta al objetivo 
func after_set_data():
	pass
	
func _process(_delta: float) -> void:
	if(Global.is_waiting_action):
		visible = false
	else:
		visible = true

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
