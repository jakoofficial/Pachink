extends Control

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@export_enum("RESET", "Fade", "Spin") var animation:String = "RESET"
var anim_done:bool = true

func play_anim():
	anim_player.play(animation)
func play_anim_backwards():
	anim_player.play_backwards(animation)
func black_screen():
	anim_player.play("Black")
func reset():
	anim_player.play("RESET")

func _on_animation_finished(anim_name: StringName) -> void:
	anim_done = true
