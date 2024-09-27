extends Node2D

var star_collected_spr:Texture = preload("res://Sprites/Collectable.png")
const star_collected_outline:Texture = preload("res://Sprites/Collectable_outline.png")
@onready var collected_stars: Array = [$"1stars", $"2stars", $"3stars"]
func _ready() -> void:
	for star in collected_stars:
		star.texture = star_collected_outline

func gameEndCollectionShow():
	#var index:int = 0
	for c in Manager.collectedStarsCurLevel:
		var star = collected_stars[c] as Sprite2D
		await get_tree().create_timer(0.5).timeout
		var tween = get_tree().create_tween().bind_node(star)
		tween.tween_property(star, "rotation", deg_to_rad(-180), .6)
		tween.tween_property(star, "scale", Vector2(3.5, 3.5), .2)
		tween.chain().tween_property(star, "scale", Vector2(3, 3), .2)
		star.texture = star_collected_spr
		var multiplier:int = c+1
		Manager.score += (20*multiplier)
	
	var prizeWon: String = %PrizeBox._checkScore()
	%PrizeWonText.text = prizeWon
	%Scoreboard._checkScores()
