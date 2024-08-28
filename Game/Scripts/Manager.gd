extends Node

var version = "a05"
var score: int = 0
var balls_left: int = 5
var canSpawn:bool = true
var windowMode = DisplayServer.WINDOW_MODE_FULLSCREEN
var is_paused = false

var boards = [
	["res://Scenes/board.tscn", "Board"],
	["res://Scenes/tumble_board.tscn", "Tumbler"]
	]

var curBoard = boards[0][0]

func _set_window_mode():
	DisplayServer.window_set_mode(windowMode)

func reset():
	score = 0
	balls_left = 5
	var balls_in_scene = get_node("/root/Board/Balls").get_children()
	for b in balls_in_scene:
		b.queue_free()
	canSpawn = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		is_paused = true
		#get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	if event.is_action_pressed("restart"):
		reset()
