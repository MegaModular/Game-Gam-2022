extends Spatial

onready var globals = $"/root/Globals"

var color = "green"

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
	if on:
		material.set_albedo(Color(0.329412, 1, 0, 1))
	if not on:
		material.set_albedo(Color(0.329412, 1, 0, 0.2))
