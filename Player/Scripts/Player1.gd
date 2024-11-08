extends KinematicBody

#Physics of player, and features

onready var head = get_node("CameraHolder")
onready var groundcheck = $Node
onready var guy = $"../MeshHolders/Yellow_guy"

onready var globals = $"/root/Globals"

#important variables to change
var min_speed = 10
var speed = 10
var max_speed = 20
var gravity = 20
var mouse_sensitivity = 0.1

var jump_force = 15

#Camera shit dont touch
var camera_zoom = 1
var min_zoom = 0.5
var max_zoom = 3
var desired_zoom = 1
var zoom_speed = 0.1

var anim_state = "idle"

#basically is_on_floor()
var full_colliding = false
var is_on_hat = false

#NotouchyCode i will execute your whole family
var sprinting = false
var h_acceleration = 6
var h_velocity = Vector3()
var movement = Vector3()
var gravity_vec = Vector3()
var direction = Vector3()

var mesh_direction = Vector2()

var hat_offset = Vector3()


var color

func _ready():
	if self.get_parent().is_in_group("yellow"):
		color = "yellow"
		self.set_collision_layer_bit(1, true)
		self.set_collision_mask_bit(1, true)
		for i in $Node.get_children():
			i.set_collision_mask_bit(1, true)
		print(self.get_collision_mask_bit(1))
	if self.get_parent().is_in_group("green"):
		color = "green"
		self.set_collision_layer_bit(2, true)
		self.set_collision_mask_bit(2, true)
		for i in $Node.get_children():
			i.set_collision_mask_bit(2, true)
		
	$CameraHolder.scale = Vector3.ONE * camera_zoom
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.

func _process(_delta):
	pass

func _input(event):
	if globals.active_player == color:
		if event is InputEventMouseMotion:
			rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
			head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
			head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
	if Input.is_action_pressed("a") or Input.is_action_pressed("w") or Input.is_action_pressed("s") or Input.is_action_pressed("d"):
		if full_colliding and globals.active_player == color:
			if sprinting:
				guy.sprint()
				anim_state = "sprint"
				$IdleTimer.set_wait_time(0.5)
				$IdleTimer.start()
			else:
				guy.walk()
				anim_state = "walk"
				$IdleTimer.set_wait_time(0.5)
				$IdleTimer.start()

var tot_collisions = 0

func check_ground():
	tot_collisions = 0
	for i in $Node.get_children():
		if i.is_colliding():
			tot_collisions += 1
	if tot_collisions > 0:
		full_colliding = true
	else:
		full_colliding = false


func _physics_process(delta):
	check_hat()
	camera_shit()
	handle_sprinting()
	#thank you garbaj 
	check_ground()
	
	if full_colliding and anim_state == "jump":
		guy.land()
		anim_state = "idle"
		
	
	direction = Vector3()
	if not full_colliding:
		gravity_vec += Vector3.DOWN * gravity * delta
	else: 
		gravity_vec = -get_floor_normal() * gravity
	
	if is_on_hat:
		gravity_vec = Vector3.UP * jump_force * 1.5
		#guy.jump()
		anim_state = "jump"
	
	if globals.active_player == color:
		if Input.is_action_just_pressed("space") and full_colliding:
			gravity_vec = Vector3.UP * jump_force
			guy.jump()
			anim_state = "jump"
		
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
		if anim_state == "sprint":
			guy.walk()

func check_hat():
	if $MiddleCast.is_colliding():
		if $MiddleCast.get_collider().is_in_group("Hat"):
			is_on_hat = true
	else:
		is_on_hat = false

func _on_Timer_timeout():
	if full_colliding:
		guy.idle()
		$IdleTimer.start()

