extends Control

@onready var prizeAmountLabel = $CenterContainer/VBoxContainer/HBoxContainer/PrizeAmount
@onready var prizeNameText: TextEdit = $CenterContainer/VBoxContainer/HBoxContainer/PrizeNameTextEdit
@onready var prizePointsAmountSpinBox: SpinBox = $CenterContainer/VBoxContainer/HBoxContainer/PrizePointsAmountSpinBox
@onready var prizeBox = preload("res://Nodes/prize_box.tscn")

var maxPrizeAmount: int = 5

func _ready() -> void:
	prizeAmountLabel.text = str(Manager.prizeAmount)+"/"+str(maxPrizeAmount)
	_load_prizes()

func _process(delta: float) -> void:
	prizeAmountLabel.text = str(Manager.prizeAmount)+"/"+str(maxPrizeAmount)
	
	if Manager.prizeAmount >= maxPrizeAmount:
		%CafeModeAddPrizeBtn.disabled = true
	else:
		%CafeModeAddPrizeBtn.disabled = false

func _load_prizes():
	Manager.prizeAmount = 0
	if Manager.prizeList.size() <= 0:
		return
	
	var keys: Array = Manager.prizeList.keys()
	var values: Array = Manager.prizeList.values()
	
	for i in Manager.prizeList.size():
		var prize_inst = prizeBox.instantiate()
		prize_inst.prize = values[i]
		prize_inst.pointAmount = int(keys[i])
		%PrizeList.add_child(prize_inst)
		Manager.prizeAmount += 1
		
	keys.clear()
	values.clear()

func _create_prize():
	if prizeNameText.text.is_empty(): return
	if Manager.prizeList.has(int(prizePointsAmountSpinBox.value)): return
	
	var prizeBox_instance = prizeBox.instantiate()
	prizeBox_instance.prize = prizeNameText.text
	prizeBox_instance.pointAmount = int(prizePointsAmountSpinBox.value)
	
	Manager.prizeList[int(prizePointsAmountSpinBox.value)] = prizeNameText.text
	%PrizeList.add_child(prizeBox_instance)
	
	prizeNameText.text = ""
	Manager.prizeAmount += 1
