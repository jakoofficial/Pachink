extends Area2D



func _on_body_entered(body):
	if body.is_in_group("Ball"):
		$AnimationPlayer.play("Hit")


func _on_animation_player_animation_finished(anim_name):
	$AnimationPlayer.play("Idle")
