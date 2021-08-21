extends KinematicBody2D

enum WeaponColor {
	Red
	Green
	Blue
	Purple
}

export var weapon_color = WeaponColor.Blue

onready var sprite = $AnimatedSprite

func _ready():
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
	sprite.get_material().set_shader_param("target_b", 0.4)

func _on_Hurtbox_area_entered(area):
	if area.get_parent().weapon_color == weapon_color:
		# TODO: Turn into grub
		queue_free()
	else:
		print("wrong color")
