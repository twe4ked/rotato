extends Node2D

func _ready():
	$RichTextLabel.visible = false

func _on_Area2D_body_entered(body):
	$RichTextLabel.visible = true
	print("entered", body)

func _on_Area2D_body_exited(body):
	$RichTextLabel.visible = false
	print("exited", body)
