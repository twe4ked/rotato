extends Node2D

export var wander_range = 32
export var horizontal_only = false

onready var start_position = global_position
onready var target_position = global_position

func update_target_position():
	var y = 0
	if !horizontal_only:
		y = rand_range(-wander_range, wander_range)

	var target_vector = Vector2(rand_range(-wander_range, wander_range), y)
	target_position = start_position + target_vector

func get_time_left():
	return $Timer.time_left

func start_timer(duration):
	$Timer.start(duration)

func _on_Timer_timeout():
	update_target_position()
