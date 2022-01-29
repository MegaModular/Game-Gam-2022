extends KinematicBody

#important variables to change
var speed = 1
var gravity = 5
#1-5
var camera_zoom = 5


var direction = Vector3()

func _ready():
	$CameraHolder.scale = Vector3.ONE * camera_zoom
	
	pass # Replace with function body.

func _process(delta):
	camera_shit()

func calculate_direction():
	pass

func camera_shit():
	$CameraHolder.scale = Vector3.ONE * camera_zoom
