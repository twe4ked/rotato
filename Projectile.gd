extends KinematicBody2D

export var speed = 6

var flip = false
var velocity = Vector2.ZERO

func _ready():
	$Sprite.flip_h = flip
	if flip:
		velocity.x = -1
	else:
		velocity.x = 1

func _physics_process(delta):
	move_and_collide(velocity * speed)

	if !$VisibilityNotifier2D.is_on_screen():
		queue_free()


func _on_Hitbox_area_entered(area):
	queue_free()
