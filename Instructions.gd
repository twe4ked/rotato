extends Node2D

func _ready():
	$RichTextLabel.visible = false

func _on_Area2D_body_entered(_body):
	$RichTextLabel.visible = true

func _on_Area2D_body_exited(_body):
	$RichTextLabel.visible = false
