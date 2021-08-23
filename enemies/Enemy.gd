extends KinematicBody2D

enum WeaponColor {
	Red
	Green
	Blue
	Purple
}

export var weapon_color = WeaponColor.Blue
export var acceleration = 4
export var max_speed = 10

onready var sprite = $AnimatedSprite
onready var wanderController = $WanderController

var Grub = load("res://Enemies/Grub.tscn")
var velocity = Vector2.ZERO

func _physics_process(delta):
	if wanderController.get_time_left() == 0:
		wanderController.start_timer(rand_range(1, 3))

	var direction = global_position.direction_to(wanderController.target_position)
	velocity = velocity.move_toward(direction * max_speed, acceleration)

	velocity = move_and_slide(velocity)

func _ready():
	match weapon_color:
		WeaponColor.Red:
			sprite.play("Red")
		WeaponColor.Green:
			sprite.play("Green")
		WeaponColor.Blue:
			sprite.play("Blue")
		WeaponColor.Purple:
			sprite.play("Purple")

func _on_Hurtbox_area_entered(area):
	if area.get_parent().weapon_color == weapon_color:
		var grub = Grub.instance()
		grub.position = global_position
		grub.weapon_color = weapon_color
		var world = get_tree().current_scene
		world.add_child(grub)

		world.get_node("EnemyHit").play()

		queue_free()
	else:
		print("wrong color")
