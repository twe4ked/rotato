extends KinematicBody2D

var velocity = Vector2.ZERO
var gravity = 10
export var acceleration = 4
export var max_speed = 10

onready var wanderController = $WanderController

func _ready():
	$AnimatedSprite.play()

func _physics_process(_delta):
	if wanderController.get_time_left() == 0:
		wanderController.start_timer(rand_range(1, 3))

	var direction = global_position.direction_to(wanderController.target_position)
	velocity = velocity.move_toward(direction * max_speed, acceleration)

	velocity.y += gravity

	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Hurtbox_area_entered(_area):
	queue_free()
