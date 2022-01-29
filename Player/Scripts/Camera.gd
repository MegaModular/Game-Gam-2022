extends Spatial

onready var Camera = $Camera

func _ready():
	pass # Replace with function body.

func _process(_delta):
	
	if $RayCast.is_colliding():
		$Camera.translation.z = $RayCast.get_collision_point().z 
	else:
		$Camera.translation.z = 6
		
