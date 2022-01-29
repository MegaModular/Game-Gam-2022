extends Spatial

onready var meshInstance = $MeshInstance3

var direction

func _ready():
	pass

func _process(delta):
	meshInstance.translation = $Player1.translation
	direction = -$Player1.movement
	if Input.is_action_pressed("w") or Input.is_action_pressed("a") or Input.is_action_pressed("s") or Input.is_action_pressed("d"):
		
		meshInstance.rotation.y = lerp_angle(meshInstance.rotation.y, atan2(direction.x, direction.z), 0.1)
