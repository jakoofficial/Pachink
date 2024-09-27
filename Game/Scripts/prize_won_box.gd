extends Panel

@onready var prizeWon = %PrizeWonText

func _checkScore() -> String:
	var prizeList = Manager.prizeList as Dictionary
	var curPrize: int = 0
	
	for p in prizeList.keys():
		if Manager.score >= p:
			curPrize = p
	
	if curPrize != 0:
		return prizeList[curPrize]
	return "Nothing"
