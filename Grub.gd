extends KinematicBody2D

var velocity = Vector2.ZERO
var gravity = 10

func _ready():
	$AnimatedSprite.play()

func _physics_process(_delta):
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Hurtbox_area_entered(_area):
	print(_area)
	queue_free()
