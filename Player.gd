extends KinematicBody2D

export var acceleration = 20
export var max_speed = 100
export var friction = 100

export var jump_height: float = 40
export var jump_time_to_peak: float = 0.4
export var jump_time_to_descent: float = 0.3

onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var velocity = Vector2.ZERO
var facing = Facing.Right

enum Facing {
	Left
	Right
}

enum WeaponColor {
	Red
	Green
	Blue
	Purple
}

var weapon_color = WeaponColor.Red

onready var sprite = $Sprite
onready var animationTree = $AnimationTree
onready var animationPlayback = animationTree.get("parameters/playback")
onready var muzzleFlashTimer = $MuzzleFlash/Timer
onready var muzzleFlash = $MuzzleFlash

onready var Projectile = load("res://Projectile.tscn")

func _ready():
	animationTree.active = true

func _process(delta):
	var world = get_tree().current_scene

	if Input.is_action_just_pressed("ui_accept"):
		muzzleFlashTimer.start(0.2)

		var projectile = spawn_projectile()
		world.add_child(projectile)

		var shoot = world.get_node("Shoot")
		shoot.stream.set_loop(false)
		shoot.play()

	if muzzleFlashTimer.time_left > 0:
		muzzleFlash.visible = true
	else:
		muzzleFlash.visible = false

	rotate_weapon_color()

	var spinner_rotation = 0.0
	match weapon_color:
		WeaponColor.Red:
			spinner_rotation = 0.0
		WeaponColor.Green:
			spinner_rotation = 90.0
		WeaponColor.Blue:
			spinner_rotation = 180.0
		WeaponColor.Purple:
			spinner_rotation = 270.0

	animationTree.set("parameters/Idle/blend_position", weapon_color)
	animationTree.set("parameters/Jumping/blend_position", weapon_color)
	animationTree.set("parameters/Running/blend_position", weapon_color)

	var weaponSpinner = world.find_node("WeaponSpinner")
	var old_rotation = weaponSpinner.get_rotation()
	weaponSpinner.set_rotation(lerp_angle(old_rotation, deg2rad(spinner_rotation), delta * 10))

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

	velocity.y += get_gravity() * delta

	if is_on_floor():
		animationPlayback.travel("Idle")
		if velocity.x != 0:
			animationPlayback.travel("Running")

	if is_on_floor() && Input.is_action_just_pressed("ui_up"):
		animationPlayback.travel("Jumping")
		velocity.y = jump_velocity

	sprite.flip_h = facing == Facing.Left

	velocity = move_and_slide(velocity, Vector2.UP)

func get_gravity() -> float:
	if velocity.y < 0.0:
		if Input.is_action_pressed("ui_up"):
			return jump_gravity
		else:
			# TODO: This multiplier is hard to get right
			return jump_gravity * 4.0
	else:
		return fall_gravity

func spawn_projectile():
	var projectile = Projectile.instance()
	projectile.weapon_color = weapon_color
	projectile.position = global_position
	projectile.position.y -= 5
	if facing == Facing.Right:
		projectile.position.x += 5
	else:
		projectile.position.x -= 21
		projectile.flip = true
	return projectile

func rotate_weapon_color():
	if Input.is_action_just_pressed("ui_down"):
		match weapon_color:
			WeaponColor.Red:
				weapon_color = WeaponColor.Green
			WeaponColor.Green:
				weapon_color = WeaponColor.Blue
			WeaponColor.Blue:
				weapon_color = WeaponColor.Purple
			WeaponColor.Purple:
				weapon_color = WeaponColor.Red
