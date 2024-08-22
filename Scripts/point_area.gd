extends Area2D

@export var points: int = 10

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ball"):
		Manager.score += points
		Manager.balls_left -= 1
		Manager.canSpawn = true
