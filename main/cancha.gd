extends Node2D
signal on_goal(player)

@onready var goal_sfx: AudioStreamPlayer = $GoalSfx

func _on_arco_2_goal(body: Node2D) -> void:
	if body is Ball:
		goal_sfx.play()
		Global.player_1_goals +=1
		body.queue_free()
		on_goal.emit()

func _on_arco_1_goal(body: Node2D) -> void:
	if body is Ball:
		goal_sfx.play()
		Global.player_2_goals +=1
		body.queue_free()
		on_goal.emit()
