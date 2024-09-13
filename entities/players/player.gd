extends RigidBody2D

#TODOs
#Poder ver el radio del mover al jugador
#Crear la clase padre para los jugadores
#Crear la carta padre para que las demas la hereden
#Que no se jueguen al momento, sino que espere a que le de a un boton


var enable_click := false
var power
var target

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 5
	gravity_scale = 0
	mass = 20
	linear_damp = 3.0 #Arrancan con 3 para frenar si algo los choca
	
func _physics_process(delta):
	set_friction()

func _on_panel_on_cart_used(data) -> void:
	print("data usada ", data.valu)
	enable_click = true
	power = data.valu

func _input(event):
	if(!enable_click): return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			target = get_global_mouse_position()
			#Ver como mejorar eso, si el player esta inclinado al momento de aplicar un
			#impulso se va para cualquier lado y no donde se hizo click
			rotation = 0 
			apply_central_impulse(get_local_mouse_position().normalized() * power)
			enable_click = false

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
