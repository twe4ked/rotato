extends KinematicBody2D

export var acceleration = 20
export var max_speed = 100
export var friction = 100
export var gravity = 10
export var max_fall_speed = 100
export var jump_force = 100

var velocity = Vector2.ZERO
var facing = Facing.Right

enum Facing {
	Left
	Right
}

onready var sprite = $AnimatedSprite
onready var muzzleFlashTimer = $MuzzleFlash/Timer
onready var muzzleFlash = $MuzzleFlash

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		muzzleFlashTimer.start(0.2)

	if muzzleFlashTimer.time_left > 0:
		muzzleFlash.visible = true
	else:
		muzzleFlash.visible = false

func _physics_process(delta):
	move(delta)

	if facing == Facing.Right:
		muzzleFlash.flip_h = false
		muzzleFlash.position.x = 14
	else:
		muzzleFlash.flip_h = true
		muzzleFlash.position.x = -14

func move(delta):
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_vector.x = 1
		facing = Facing.Right
	elif Input.is_action_pressed("ui_left"):
		input_vector.x = -1
		facing = Facing.Left

	if input_vector.x != 0:
		velocity.x = move_toward(velocity.x, input_vector.x * max_speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, friction)

	velocity.y += gravity * delta
	if velocity.y > max_fall_speed:
		velocity.y = max_fall_speed

	if is_on_floor() && Input.is_action_just_pressed("ui_up"):
		velocity.y = -jump_force

	sprite.flip_h = facing == Facing.Left

	velocity = move_and_slide(velocity, Vector2.UP)
