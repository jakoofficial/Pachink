extends Area2D

@export var points: int = 10
@export var effect_color: Color = Color.DARK_ORANGE
@onready var points_text = $pointsText
@onready var effect = $GPUParticles2D as GPUParticles2D

func _ready() -> void:
	points_text.text = str(points)
	effect.modulate = effect_color

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ball"):
		Manager.score += points
		Manager.canSpawn = true
		effect.emitting = true
