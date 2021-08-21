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

	var hue = 0.0
	match weapon_color:
		WeaponColor.Red:
			hue = 0.0
		WeaponColor.Green:
			hue = 0.3
		WeaponColor.Blue:
			hue = 0.6
		WeaponColor.Purple:
			hue = 0.7
	sprite.get_material().set_shader_param("hue", hue)

func _physics_process(delta):
	move_and_collide(velocity * speed)

	if !$VisibilityNotifier2D.is_on_screen():
		queue_free()

func _on_Hitbox_area_entered(area):
	queue_free()
