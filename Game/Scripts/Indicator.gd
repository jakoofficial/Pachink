extends Area2D

@export var move_speed:float = 10.0

@onready var ball = preload("res://Nodes/ball.tscn")
@onready var spawner = $Spawner
@onready var sprite = $Sprite2D as Sprite2D

var viewport_size = Vector2(0, 0)
func _ready() -> void:
	viewport_size = get_viewport().content_scale_size
	print(viewport_size)

func _input(event: InputEvent) -> void:
	if event.is_action("drop_ball") and Manager.canSpawn:
		# Drop a ball
		var ball_inst = ball.instantiate() as RigidBody2D
		ball_inst.global_position = Vector2(spawner.global_position.x, spawner.global_position.y)
		get_tree().root.add_child(ball_inst)
		Manager.canSpawn = false
		Manager.balls_left -= 1


func _physics_process(delta: float) -> void:
	var posX = self.global_position.x
	#Bounce Indicator at the edge of the viewport
	if posX > viewport_size.x - (sprite.texture.get_width() / 2) or posX < 0 + (sprite.texture.get_width()/2):
		move_speed = -move_speed
	# Move Indicator
	self.global_position.x += move_speed * 100 * delta
