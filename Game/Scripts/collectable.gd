extends Area2D

@onready var sprite = $Sprite2D

@export var moveSpd: float = 0.2
@export var moveLenght: float = 1

var tween
func _ready() -> void:
	tween = get_tree().create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween.tween_property(sprite, "scale", Vector2(2.2, 2.2), 0.75)
	tween.chain().tween_property(sprite, "scale", Vector2(2, 2), 0.75)

func _process(delta):
	sprite.rotation -= deg_to_rad(moveLenght - moveSpd)
	if Manager.gameOver:
		tween.kill()

func hit():
	Manager.collectedStarsCurLevel += 1
	tween.kill()
	$Drip.emitting = false
	$CollisionShape2D.queue_free()
	$CPUParticles2D.emitting = true
	sprite.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ball"):
		hit()
		Manager.score += 20

func _on_cpu_particles_2d_finished() -> void:
		call_deferred("queue_free")
