extends Control

@export var prize: String = "Prize"
@export var pointAmount: int = 0

@onready var prize_text: Label = $PointPrize/PrizeText
@onready var points_amount: Label = $PointPrize/PointsAmount
@onready var remove_btn: Button = $PointPrize/RemovePrizeBtn

func _ready() -> void:
	prize_text.text = str(prize)
	points_amount.text = str(pointAmount)

func _removePrize_click() -> void:
	Manager.prizeList.erase(self)
	queue_free()
