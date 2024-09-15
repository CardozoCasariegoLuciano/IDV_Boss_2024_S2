extends RigidBody2D
class_name Player

#TODOs Backlog
#Agregar mas cartas, tratando de generalizar las modificaciones que tengamos que hacer
#Que no salgan de la cancha
#Que no se pueda usar las cartas propias en los jugadores rivales
#Poder ver en pantalla el radio de las distintas acciones (para que no tengan alcance infinito)
#Poder ver en pantalla las acciones ya jugadas en mi turno
#Agregar todo el sistema de mana
#Agregar la pantalla de blokeo entre turnos y la de "espera" para ejecutar las acciones
#Crear la clase padre para los jugadores y que sea facil agregar los nuevos tipos
#Agregar los DTs (creando clase padre para que sean escalable)
#Agregar los feedbacks al usuario (por ejemplo cuando quiere patear pero no tiene la pelota)
#Permitir concatenar jugadas, para eso pense que cuando se mueve (por ejemplo) si bien no se ejecuta la accion, le podemos mostrar la silueta para que aplique otra jugada ahi mismo
#Dibujar bien la cancha y definir los arcos
#Diseñar lo visual de los jugadores
#Diseñar lo visual de las cartas
#Mostrar la UI completa, con el turno actual, duracion de la partida, Mana actual, etc
#Crear el Menu principal (nombre del juego, boton Jugar, boton salir, etc)
#Crear la pantalla de creacion de mazos, seleccion de DT y de capitan

var enable_click := false
var used_cart: Card_template
var target
var ball: Ball

func _ready() -> void:
	initial_properties()
	Global.can_execute.connect(execute_move)


func _physics_process(delta):
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
	
	
	
	
	
	
