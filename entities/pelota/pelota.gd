extends RigidBody2D
class_name Ball

@onready var timer: Timer = $Timer

func _ready() -> void:
	Global.can_execute.connect(change_friction)

func change_friction(can_execute: bool):
	if can_execute:
		timer.start()
	else:
		linear_damp = .6

func _on_timer_timeout() -> void:
	linear_damp = 2
