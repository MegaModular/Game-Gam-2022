extends KinematicBody

#Physics of player, and features

onready var head = get_node("CameraHolder")
onready var groundcheck = $GroundCheck

onready var globals = $"/root/Globals"

#important variables to change
var min_speed = 10
var speed = 10
var max_speed = 20
var gravity = 20
var mouse_sensitivity = 0.1

var jump_force = 10

#Camera shit dont touch
var camera_zoom = 1
var min_zoom = 0.5
var max_zoom = 3
var desired_zoom = 1
var zoom_speed = 0.1

#basically is_on_floor()
var full_colliding = false

#NotouchyCode i will execute your whole family
var sprinting = false
var h_acceleration = 6
var h_velocity = Vector3()
var movement = Vector3()
var gravity_vec = Vector3()
var direction = Vector3()

var mesh_direction = Vector2()

var color

func _ready():
	if self.get_parent().is_in_group("yellow"):
		color = "yellow"
	if self.get_parent().is_in_group("green"):
		color = "green"
	$CameraHolder.scale = Vector3.ONE * camera_zoom
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.

func _process(delta):
	turn_onoff()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
	

func _physics_process(delta):
	camera_shit()
	handle_sprinting()
	#thank you garbaj 
	direction = Vector3()
	
	if groundcheck.is_colliding():
		full_colliding = true
	else:
		full_colliding = false
	
	if not full_colliding:
		gravity_vec += Vector3.DOWN * gravity * delta
	else: 
		gravity_vec = -get_floor_normal() * gravity
	
	if globals.active_player == color:
		if Input.is_action_just_pressed("space") and full_colliding:
			gravity_vec = Vector3.UP * jump_force
		
		if Input.is_action_pressed("w"):
			direction -= transform.basis.z
		if Input.is_action_pressed("s"):
			direction += transform.basis.z
		if Input.is_action_pressed("a"):
			direction -= transform.basis.x
		if Input.is_action_pressed("d"):
			direction += transform.basis.x
	
	direction = direction.normalized()
	
	h_velocity = h_velocity.linear_interpolate(direction * speed, h_acceleration * delta)
	movement.z = h_velocity.z + gravity_vec.z
	movement.x = h_velocity.x + gravity_vec.x
	movement.y = gravity_vec.y
	
	#if globals.active_player == color:
	move_and_slide(movement, Vector3.UP)

func _unhandled_input(event):
	if event.is_action_pressed("scroll_up"):
		desired_zoom -= zoom_speed
	if event.is_action_pressed("scroll_down"):
		desired_zoom += zoom_speed

func camera_shit():
	$CameraHolder.scale = Vector3.ONE * camera_zoom
	camera_zoom = lerp(camera_zoom, desired_zoom, 0.2)
	camera_zoom = clamp(camera_zoom, min_zoom, max_zoom)
	desired_zoom = clamp(desired_zoom, min_zoom, max_zoom)

func handle_sprinting():
	if Input.is_action_pressed("shift"):
		sprinting = true
		speed = max_speed
	else:
		sprinting = false
		speed = min_speed


func turn_onoff():
	#if globals.active_player == color:
	#	self.set_physics_process(true)
	#if globals.active_player != color:
	#	self.set_physics_process(false)
	pass
