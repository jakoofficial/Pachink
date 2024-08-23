extends Control

@onready var score_text = $ScoreText
@onready var balls_left_text = $BallsLeftText

func _ready() -> void:
	score_text.text = str(Manager.score)
	balls_left_text.text = str(Manager.balls_left)

func _process(delta: float) -> void:
	score_text.text = "Score: " + str(Manager.score)
	balls_left_text.text = "Balls: "+str(Manager.balls_left)
