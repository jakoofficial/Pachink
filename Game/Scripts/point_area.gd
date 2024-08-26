extends Area2D

@export var points: int = 10
@export var effect_color: Color = Color.DARK_ORANGE
@export var effect_life: float = 1
@export var effect_amount: int = 15
@onready var points_text = $pointsText
@onready var effect = $CPUParticles2D as CPUParticles2D

func _ready() -> void:
	points_text.text = str(points)
	effect.modulate = effect_color
	effect.lifetime = effect_life
	effect.amount = effect_amount

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ball"):
		Manager.score += points
		Manager.canSpawn = true
		effect.emitting = true
