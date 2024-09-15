extends Card_template

func _ready() -> void:
	power = 400
	require_click = true

func apply_action():
	var ball = player.ball
	if(ball):
		var impuse = (click_point - player.global_position).normalized() * power
		ball.apply_central_impulse(impuse)
		ball.player_owner = null
		player.ball = null
		ball.set_physics_process(false)
	else:
		print("El jugador no tiene la pelota para patearla")
