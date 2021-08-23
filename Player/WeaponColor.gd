extends Node

enum WeaponColor {
	Red
	Green
	Blue
	Purple
}

func default():
	return WeaponColor.Red

func spin_rotation(weapon_color):
	match weapon_color:
		WeaponColor.Red:
			return 0.0
		WeaponColor.Green:
			return 90.0
		WeaponColor.Blue:
			return 180.0
		WeaponColor.Purple:
			return 270.0

func next(weapon_color):
	match weapon_color:
		WeaponColor.Red:
			return WeaponColor.Green
		WeaponColor.Green:
			return WeaponColor.Blue
		WeaponColor.Blue:
			return WeaponColor.Purple
		WeaponColor.Purple:
			return WeaponColor.Red

func name(weapon_color):
	return WeaponColor.keys()[weapon_color]
