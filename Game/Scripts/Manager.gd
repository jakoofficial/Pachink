extends Node

var version = "a05"
var score: int = 0
var balls_left: int = 5
var gameOver: bool = false
var canSpawn:bool = true
var windowMode = DisplayServer.WINDOW_MODE_FULLSCREEN
var is_paused = false
var boards = [
	["res://Scenes/board.tscn", "Boing", "res://Sprites/Board_icons/ico_Boing.png"],
	["res://Scenes/tumble_board.tscn", "Tumble", "res://Sprites/Board_icons/ico_Tumble.png"]
	]

var curBoard = boards[0][0]

func _set_window_mode():
	DisplayServer.window_set_mode(windowMode)

func reset():
	score = 0
	balls_left = 5
	gameOver = false
	var balls_in_scene = get_node("/root/Board/Balls").get_children()
	for b in balls_in_scene:
		b.queue_free()
	canSpawn = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit") and !gameOver:
		is_paused = true
		#get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	if event.is_action_pressed("restart"):
		reset()
