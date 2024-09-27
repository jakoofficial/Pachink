extends Node

var version = "a07.1"
var score: int = 0
var ball_count:int = 5
var balls_left: int
var gameOver: bool = false
var canSpawn:bool = true
#var windowMode = DisplayServer.WINDOW_MODE_FULLSCREEN
var windowMode = DisplayServer.WINDOW_MODE_WINDOWED
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
var ballsInGame: Array = []
var allowBallSpam: bool = false
var ballLocation: Vector2
var cafeMode: bool = false
var mouseOverSpawn: bool = false

var prizeAmount: int = 0
var prizeList: Dictionary = {}

var highscores: Dictionary = {"Jay": 1, "Kasper": 5, "asd": 3}

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
	if event.is_action_pressed("restart"):
		reset()
