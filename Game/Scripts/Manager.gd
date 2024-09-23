extends Node

var version = "a06"
var score: int = 0
var ball_count:int = 5
var balls_left: int
var gameOver: bool = false
var canSpawn:bool = true
var windowMode = DisplayServer.WINDOW_MODE_FULLSCREEN
var is_paused = false
var gamerulesChanged = false
var boards = [
	["res://Scenes/board.tscn", "Boing", "res://Sprites/Board_icons/ico_Boing.png"],
	["res://Scenes/tumble_board.tscn", "Tumble", "res://Sprites/Board_icons/ico_Tumble.png"],
	["res://Scenes/jackpot.tscn", "Jackpot", "res://Sprites/Board_icons/ico_Jackpot.png"],
	]

var curBoard = boards[0][0]
var collectedStarsTotal: int = 0
var collectedStarsCurLevel: int = 0

func _ready():
	balls_left = ball_count

func _set_window_mode():
	DisplayServer.window_set_mode(windowMode)

func update_settings():
	balls_left = ball_count
	
	gamerulesChanged = false


func reset():
	score = 0
	collectedStarsCurLevel = 0
	balls_left = ball_count
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
