extends Spatial

#Controls animations and camera and meshes

onready var meshInstance = $MeshHolders
onready var globals = $"/root/Globals"


var direction

var color

func _ready():
	if self.is_in_group("yellow"):
		color = "yellow"
		$MeshHolders/Green.queue_free()
		print("queue free gree")
	if self.is_in_group("green"):
		color = "green"
		$MeshHolders/Yellow.queue_free()
		print("queue free yellow")

func _process(delta):
	turn_camera_onoff()
	meshInstance.translation = $Player1.translation
	direction = -$Player1.movement
	if globals.active_player == color:
		if Input.is_action_pressed("w") or Input.is_action_pressed("a") or Input.is_action_pressed("s") or Input.is_action_pressed("d"):
			
			meshInstance.rotation.y = lerp_angle(meshInstance.rotation.y, atan2(direction.x, direction.z), 0.1)

func turn_camera_onoff():
	if color == globals.active_player:
		$Player1/CameraHolder/ClippedCamera.current = true
	else:
		$Player1/CameraHolder/ClippedCamera.current = false
