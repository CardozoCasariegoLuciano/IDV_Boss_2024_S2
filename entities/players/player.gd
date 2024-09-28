extends RigidBody2D
class_name Player

var enable_click := false
var used_cart: Card_template
var target
var ball: Ball

var userOwner

func initialize(marker: Marker2D, userOwner_id: int):
	self.userOwner = userOwner_id
	global_position = marker.global_position
	if userOwner == 2:
		modulate = "ff41ff"

func _ready() -> void:
	initial_properties()
	Global.can_execute.connect(execute_move)

func _physics_process(_delta):
	set_friction()


func execute_move(can_execute: bool):
	if(can_execute and used_cart != null):
		used_cart.apply_action()
		used_cart = null


func _on_panel_on_cart_used(data: Card_template) -> void:
	enable_click = true
	used_cart = data


func _input(event):
	if(!enable_click): return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			target = get_global_mouse_position()
			
			var angle = (target - global_position).angle()
			set_deferred("rotation", angle)
			
			used_cart.set_data(self, event.position)
			used_cart.use_card()
			enable_click = false


func set_friction():
	angular_damp = 100.0
	
	if target != null:
		if global_position.distance_to(target) < 10:
			#Si ya llegaron al objetivo se paran
			linear_damp = 100.0 
			
			target = null
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
	mass = 20


func _on_body_entered(body: Node) -> void:
	target = null
	
	if(body is Ball):
		body.change_owner(self)
	
	
	
	
	
	
