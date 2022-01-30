extends Node

#"yellow", "green"
var active_player = "yellow"


func _process(_delta):
	if Input.is_action_pressed("escape"):
		get_tree().quit()
	if Input.is_action_just_pressed("q"):
		if active_player == "yellow":
			active_player = "green"
		else:
			active_player = "yellow"
