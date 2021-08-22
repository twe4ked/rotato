extends Node2D

onready var gameEndedTimer = $GameEndedTimer

onready var enemies = 4
onready var time = 0

func _process(delta):
	var elapsedTime = get_node("ElapsedTime")

	if enemies <= 0:
		# Game finished
		elapsedTime.text = str("You finished in %.2fs!" % time)
		if gameEndedTimer.is_stopped():
			gameEndedTimer.start(3)
	else:
		time += delta
		elapsedTime.text = str("%.2fs" % time)

func count_enemy_killed():
	# TODO: Signal
	enemies -= 1

func _on_GameEndedTimer_timeout():
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
