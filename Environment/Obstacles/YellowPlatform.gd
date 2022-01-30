extends Spatial

onready var globals = $"/root/Globals"

var color = "yellow"

var on = false

var material

func _ready():
	material = $MeshInstance.get_active_material(0)

func _process(_delta):
	if globals.active_player == color:
		on = true
		update_color()
	elif globals.active_player != color:
		on = false
		update_color()
	

func update_color():
#	if on:
#		material.set_albedo(Color(1, 0.831373, 0.05098, 1))
#	if not on:
#		material.set_albedo(Color(1, 0.831373, 0.05098, 0.2))
	pass
