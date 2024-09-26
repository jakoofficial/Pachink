extends Panel

@onready var prizeWon = %PrizeWonText

func _onGameDone():
	var prizeList = Manager.prizeList as Dictionary
	#Manager.prizeList as Array
	print(prizeList)
	#for p in prizeList
	
