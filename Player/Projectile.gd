extends KinematicBody2D

export var speed = 6

var flip = false
var velocity = Vector2.ZERO
var weapon_color = WeaponColor.default()

onready var sprite = $Sprite

func _ready():
	sprite.flip_h = flip
	if flip:
		velocity.x = -1
	else:
		velocity.x = 1

	match weapon_color:
		WeaponColor.WeaponColor.Red:
			sprite.frame = 44
		WeaponColor.WeaponColor.Green:
			sprite.frame = 80
		WeaponColor.WeaponColor.Blue:
			sprite.frame = 79
		WeaponColor.WeaponColor.Purple:
			sprite.frame = 69

func _physics_process(_delta):
	var _c = move_and_collide(velocity * speed)

	if !$VisibilityNotifier2D.is_on_screen():
		queue_free()

func _on_Hitbox_area_entered(_area):
	queue_free()
