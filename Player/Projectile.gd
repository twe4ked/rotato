extends KinematicBody2D

export var speed = 6

var flip = false
var velocity = Vector2.ZERO
export(int) var weapon_color = WeaponColor.Red

onready var sprite = $Sprite

enum WeaponColor {
	Red
	Green
	Blue
	Purple
}

func _ready():
	sprite.flip_h = flip
	if flip:
		velocity.x = -1
	else:
		velocity.x = 1

	match weapon_color:
		WeaponColor.Red:
			sprite.frame = 44
		WeaponColor.Green:
			sprite.frame = 80
		WeaponColor.Blue:
			sprite.frame = 79
		WeaponColor.Purple:
			sprite.frame = 69

func _physics_process(_delta):
	var _c = move_and_collide(velocity * speed)

	if !$VisibilityNotifier2D.is_on_screen():
		queue_free()

func _on_Hitbox_area_entered(_area):
	queue_free()
