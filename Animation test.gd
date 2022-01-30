extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var anim_tree
var state_machine
# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

func _input(event):
	if Input.is_action_just_pressed("a"):
		
		state_machine.travel("walk")
		print(state_machine)
	if Input.is_action_just_pressed("space"):
		state_machine.travel("air")
	if Input.is_action_just_pressed("w"):
		state_machine.travel("Idle")
	if Input.is_action_just_pressed("shift"):
		state_machine.travel("Sprint")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
