extends Control

@onready var prizeAmountLabel = $CenterContainer/VBoxContainer/HBoxContainer/PrizeAmount
@onready var prizeNameText: TextEdit = $CenterContainer/VBoxContainer/HBoxContainer/PrizeNameTextEdit
@onready var prizePointsAmountSpinBox: SpinBox = $CenterContainer/VBoxContainer/HBoxContainer/PrizePointsAmountSpinBox

var prizeBox = preload("res://Nodes/prize_box.tscn")
var maxPrizeAmount: int = 5

func _ready() -> void:
	prizeAmountLabel.text = str(Manager.prizeList.size())+"/"+str(maxPrizeAmount)

func _process(delta: float) -> void:
	prizeAmountLabel.text = str(Manager.prizeList.size())+"/"+str(maxPrizeAmount)
	
	if Manager.prizeList.size() >= maxPrizeAmount:
		%CafeModeAddPrizeBtn.disabled = true
	else:
		%CafeModeAddPrizeBtn.disabled = false

func _create_prize():
	if prizeNameText.text.is_empty(): return
	
	var prizeBox_instance = prizeBox.instantiate()
	prizeBox_instance.prize = prizeNameText.text
	prizeBox_instance.pointAmount = int(prizePointsAmountSpinBox.value)
	
	Manager.prizeList.append(prizeBox_instance)
	%PrizeList.add_child(prizeBox_instance)
	
	prizeNameText.text = ""
