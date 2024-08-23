extends Node

var score: int = 0
var balls_left: int = 5
var canSpawn:bool = true

func reset():
	score = 0
	balls_left = 5

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if event.is_action_pressed("restart"):
		reset()
