extends Area2D

@export var points: int = 10
@onready var points_text = $pointsText

func _ready() -> void:
	points_text.text = str(points)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ball"):
		Manager.score += points
		Manager.canSpawn = true
