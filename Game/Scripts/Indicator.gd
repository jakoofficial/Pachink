extends Area2D

@export var move_speed:float = 10.0

@onready var ball = preload("res://Nodes/ball.tscn")
@onready var spawner = $Spawner
@onready var sprite = $Sprite2D as Sprite2D
@onready var GUI = $"../CanvasLayer/GUI"

var viewport_size = Vector2(0, 0)
func _ready() -> void:
	viewport_size = get_viewport().content_scale_size
	print(viewport_size)
	GUI.clickArea.connect(drop_ball)

func drop_ball():
	# Drop a ball
	if Manager.canSpawn and Manager.balls_left > 0 and !Manager.is_paused:
		var ball_inst = ball.instantiate() as RigidBody2D
		var tweenDrop = get_tree().create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
		tweenDrop.tween_property(sprite, "scale", Vector2(1, 0.75), 0.1)
		tweenDrop.tween_property(sprite, "scale", Vector2(1, 1), 0.1)
		
		ball_inst.global_position = Vector2(spawner.global_position.x, spawner.global_position.y)
		get_tree().root.get_node("/root/Board/Balls").add_child(ball_inst)
		Manager.canSpawn = false
		Manager.balls_left -= 1
	else:
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
		tween.tween_property(sprite, "modulate", Color.RED, .05)
		randomize()
		if randi_range(0, 1) == 0:
			tween.tween_property(sprite, "rotation_degrees", 10, .1).as_relative()
			tween.tween_property(sprite, "rotation_degrees", -10, .1).as_relative()
		else:
			tween.tween_property(sprite, "rotation_degrees", -10, .1).as_relative()
			tween.tween_property(sprite, "rotation_degrees", 10, .1).as_relative()
		tween.tween_property(sprite, "modulate", Color.WHITE, .05)
		#tween.tween_property(sprite, "scale", Vector2(1.1,1.1), .1)
		

func _input(event):
	if event.is_action_pressed("drop_ball"):
		drop_ball()

func _physics_process(delta: float) -> void:
	var posX = self.global_position.x
	#Bounce Indicator at the edge of the viewport
	if posX > viewport_size.x - (sprite.texture.get_width() / 2) or posX < 0 + (sprite.texture.get_width()/2):
		move_speed = -move_speed
	# Move Indicator
	self.global_position.x += move_speed * 100 * delta
