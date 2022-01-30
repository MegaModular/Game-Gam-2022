extends Spatial

onready var globals = $"/root/Globals"

var color = "green"
var flipflop = true
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
#		material.set_albedo(Color(0.329412, 1, 0, 1))
#	if not on:
#		material.set_albedo(Color(0.329412, 1, 0, 0.2))
	pass

func _input(event):
	if Input.is_action_just_pressed("q"):
		if Globals.active_player == "green":
			var material = $MeshInstance.get_surface_material(0)
			material.albedo_color = Color(1, 0, 0, .9)
			$MeshInstance.set_surface_material(0, material)
			material.flags_transparent = true
			flipflop = false
		elif Globals.active_player == "yellow":
			var material = $MeshInstance.get_surface_material(0)
			material.albedo_color = Color(1, 0, 0, 1)
			material.flags_transparent = false
			$MeshInstance.set_surface_material(0, material)
			flipflop = true
