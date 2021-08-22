extends KinematicBody2D

enum WeaponColor {
	Red
	Green
	Blue
	Purple
}

export var weapon_color = WeaponColor.Blue

onready var sprite = $AnimatedSprite

var Grub = load("res://Grub.tscn")

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
		var world = get_tree().current_scene
		world.add_child(grub)

		queue_free()
	else:
		print("wrong color")
