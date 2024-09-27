extends Panel
@onready var first_place: Label = $ScoreboardVbox/first/firstName
@onready var second_place: Label = $ScoreboardVbox/second/secondName
@onready var third_place: Label = $ScoreboardVbox/third/thirdName

var scoreLabelArr: Array = []
var scores: Array = []

func _ready() -> void:
	scoreLabelArr = [first_place, second_place, third_place]
	
func _checkScores() -> void:
	var tempScore: String = ""
	var scoreboardPos: int = 3
	for i in Manager.highscores.keys():
		var score: int = Manager.highscores[i]
		if Manager.score > score:
			score = Manager.score
			tempScore = "Score " + str(score) + " | " + i
			scoreboardPos -= 1
	if scoreboardPos < 3:
		var newScore: String = "pos: "+ str(scoreboardPos) + " " +tempScore
		scores.append(newScore)
		print(newScore)

func _updateBoard() -> void:
	var values = Manager.highscores.values()
	var keys = Manager.highscores.keys()

func _setupBoard() -> void:
	scoreLabelArr[0].text = "TBD"
	scoreLabelArr[1].text = "TBD"
	scoreLabelArr[2].text = "TBD"
