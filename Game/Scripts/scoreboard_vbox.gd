extends VBoxContainer

var pName: String = "A"
var score: String = "0"
func _ready() -> void:
	$HighscoreName.text = pName
	$Highscore.text = score
