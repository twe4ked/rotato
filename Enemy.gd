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
		# TODO: Turn into grub
		queue_free()
	else:
		print("wrong color")
