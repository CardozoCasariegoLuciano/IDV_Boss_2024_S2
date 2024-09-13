extends RigidBody2D

#TODOs
#Que no salgan de la cancha
#Poder ver el radio del mover al jugador
#Crear la clase padre para los jugadores
#Crear la carta padre para que las demas la hereden
#Dibujar bien la cancha y definir los arcos
#Mostrar toda la UI

var enable_click := false
var used_cart: Cart
var target
var action_saved

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 5
	gravity_scale = 0
	mass = 20
	linear_damp = 3.0 #Arrancan con 3 para frenar si algo los choca
	
func _physics_process(delta):
	set_friction()
	execute_move()

func execute_move():
	if !action_saved or !Global.can_execute: return
	apply_central_impulse(action_saved)
	action_saved = null
		
func _on_panel_on_cart_used(data: Cart) -> void:
	enable_click = true
	used_cart = data

func _input(event):
	if(!enable_click): return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			target = get_global_mouse_position()
			#Ver como mejorar eso, si el player esta inclinado al momento de aplicar un
			#impulso se va para cualquier lado y no donde se hizo click
			rotation = 0 
			action_saved = (get_local_mouse_position().normalized() * used_cart.valu)
			enable_click = false
			used_cart.queue_free()

func set_friction():
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

func _on_body_entered(body: Node) -> void:
	#Si ya llegaron al objetivo se paran
	linear_damp = 10.0 
	target = null
