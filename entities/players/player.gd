extends RigidBody2D
class_name Player

var enable_click := false
var used_cards: Array[Card_template]
var click_position

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

func _physics_process(_delta):
	set_friction()

func execute_move(can_execute: bool):
	if(can_execute and !used_cards.is_empty()):
		for card in used_cards:
			card.apply_action()

func _on_panel_on_cart_used(data: Card_template) -> void:
	if(data.use_in_field):
		data.change_card_visibility(1)
		return
	if(!used_cards.is_empty() and used_cards[-1].can_concatenate):
		used_cards.append(data)
	else:
		used_cards = [data]
	enable_click = data.require_click

	if(!data.require_click):
		data.set_data(self, Vector2.ZERO)

func _input(event):
	if(!enable_click or used_cards.is_empty()): return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			click_position = get_global_mouse_position()
			
			var angle = (click_position - global_position).angle()
			set_deferred("rotation", angle)
			var last_card = used_cards[-1]
			last_card.set_data(self, event.position)
			enable_click = false

func set_friction():
	angular_damp = 100.0
	
	if click_position != null:
		if global_position.distance_to(click_position) < 10:
			#Si ya llegaron al objetivo se paran
			linear_damp = 100.0 
			
			click_position = null
		else:
			 #Si aun no llego se pueden seguir moviendo
			linear_damp = 0
	else:
		#Si ya no hay target vuelve con los valores iniciales
		linear_damp = 3.0 

func initial_properties():
	contact_monitor = true
	max_contacts_reported = 5
	gravity_scale = 0
	scale = Vector2(1,1)
	mass = 20
	if userOwner == 1:
		modulate = Color(1,1,1,1)
	else:
		modulate = "ff41ff"

func _on_body_entered(_body: Node) -> void:
	click_position = null

func clean_player(can_clean: bool) -> void:
	if(can_clean): 
		for card in used_cards:
			card.clean_target()
		used_cards.clear()
