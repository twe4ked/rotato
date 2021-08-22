extends KinematicBody2D

var velocity = Vector2.ZERO
var gravity = 10

export var acceleration = 4
export var max_speed = 10
export var death_range_max = 10

onready var wanderController = $WanderController

enum State {
	Alive
	Dead
}

var state = State.Alive

func _ready():
	$AnimatedSprite.play()

func _physics_process(delta):
	match state:
		State.Alive:
			if wanderController.get_time_left() == 0:
				wanderController.start_timer(rand_range(1, 3))

			var direction = global_position.direction_to(wanderController.target_position)
			velocity = velocity.move_toward(direction * max_speed, acceleration)

			velocity.y += gravity

			velocity = move_and_slide(velocity, Vector2.UP)

		State.Dead:
			position += velocity * delta * 400
			rotation_degrees += 400 * delta

func _on_Hurtbox_area_entered(_area):
	velocity = Vector2(rand_range(0, death_range_max), rand_range(0, -death_range_max)).normalized()
	state = State.Dead

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
