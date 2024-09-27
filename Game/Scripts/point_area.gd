extends Area2D

@export var points: int = 10

@export_group("Effect")
##Particle color (White as standard)
@export var effect_color: Color = Color.WHITE
@export var rainbow:bool = false
##Particle lifespan
@export var effect_life: float = 1
@export var effect_amount: int = 15

@onready var points_text = $pointsText
@onready var effect = $CPUParticles2D as CPUParticles2D
@onready var balls: Node2D = $"../../Balls"

func _ready() -> void:
	points_text.text = str(points)
	if rainbow:
		effect.modulate = Color.DARK_GRAY
		effect.hue_variation_min = 1
		effect.hue_variation_max = 1
	else:
		effect.modulate = effect_color
		effect.hue_variation_min = 0
		effect.hue_variation_max = 0
	effect.lifetime = effect_life
	effect.amount = effect_amount

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ball"):
		Manager.score += points
		Manager.canSpawn = true
		effect.emitting = true
		Manager.ballsInGame.erase(body)
		if Manager.balls_left <= 0 and Manager.ballsInGame.size() <= 0:
			await get_tree().create_timer(.6).timeout
			Manager.gameOver = true
