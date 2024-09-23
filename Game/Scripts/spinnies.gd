extends Node2D

@export var spin_speed: float = 1.0
@onready var spin_clock = $SpinClock
@onready var spin_counter_clock = $SpinCounterClock

func _physics_process(delta):
	spin_clock.rotation += deg_to_rad(spin_speed)
	spin_counter_clock.rotation += deg_to_rad(-spin_speed)
