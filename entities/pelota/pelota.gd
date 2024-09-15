extends RigidBody2D
class_name Ball

var player_owner: Player
@export var distance_ahead: float = 50 # Distancia por delante

func _ready() -> void:
	linear_damp = 1.0
	angular_damp = 1.0
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	#print("tiene player ", player_owner)

	if(player_owner):
		#Muy WTF esto, si saco esta variable (que no se usa) se buguea la pelota
		var ball_global_position = global_position 
		
		var direction = (player_owner.global_transform.x).normalized()
		var target_position = player_owner.global_position + direction * distance_ahead
		global_position = target_position


func change_owner(player: Player):
	if(player_owner and player_owner != player):
		player_owner.ball = null
	
	player.ball = self
	self.player_owner = player
	set_physics_process(true)
