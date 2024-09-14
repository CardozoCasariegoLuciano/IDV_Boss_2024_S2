extends Card_template

func _ready() -> void:
	power = 400
	require_click = true

func apply_action():
	var ball = player.ball
	if(ball):
		ball.set_physics_process(false)
		ball.apply_central_impulse(point * power)
		
		ball.player_owner = null
		player.ball = null
	else:
		print("El jugador no tiene la pelota para patearla")
