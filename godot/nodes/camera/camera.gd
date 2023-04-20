extends Node3D

@onready var camera : Camera3D = $Horizontal/Vertical/Camera3D

var dragging = false
var zooming = false

# variables for turning horizontal gimbal
var h_rotation = 0
var h_sensitivity = 0.1
var h_speed = 30

# variables for turning vertical gimbal
var v_rotation = -20
var v_sensitivity = 0.1
var v_speed = 30
var v_min = -55
var v_max = 75

# variables changing camera z position (zoom)
var z_position = 100
var z_sensitivity = 0.01
var z_speed = 5
var z_min = 20
var z_max = 1500

# variables for touch inputs
var events = {}
var last_drag_distance = 0


func _unhandled_input(event):
	
	# MOUSE EVENTS
	# -------------------------------
	if event is InputEventMouseButton:
		if event.is_pressed():
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					dragging = true
				MOUSE_BUTTON_WHEEL_UP:
					_change_cam_zoom("IN", 10)

				MOUSE_BUTTON_WHEEL_DOWN:
					_change_cam_zoom("OUT", 20)
					
		else:
			dragging = false

		
#		if event.button_index == MOUSE_BUTTON_LEFT:
#			dragging = (true) if event.is_pressed() else (false)
#
#		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN or MOUSE_BUTTON_WHEEL_UP:
#			if event.is_pressed():
#				zooming = true
				
#			zooming = (true) if event.is_pressed() else (false)
			
		
	if event is InputEventMouseMotion and dragging:
		_change_cam_rotation(event)
	
	
		
	# TOUCH EVENTS
	# -------------------------------
	if event is InputEventScreenTouch:
		if event.pressed:
			events[event.index] = event
		else:
			events.erase(event.index)

	if event is InputEventScreenDrag:
		events[event.index] = event

		if events.size() == 1:
			_change_cam_rotation(event)

		elif events.size() == 2:
			var drag_distance = events.values()[0].position.distance_to(events.values()[1].position)
			if abs(drag_distance - last_drag_distance) > z_sensitivity:
				_change_cam_zoom("OUT", 2) if drag_distance < last_drag_distance else _change_cam_zoom("IN", 1)
				last_drag_distance = drag_distance
				

func _change_cam_rotation(event):
		h_rotation += -event.relative.x * h_sensitivity
		v_rotation += -event.relative.y * v_sensitivity

func _change_cam_zoom(direction, multiplier):
		if direction == "IN":
			z_position -= camera.position.z * z_sensitivity * multiplier
		else:
			z_position += camera.position.z * z_sensitivity * multiplier


func _physics_process(delta):
#	if zooming:
	z_position = clamp(z_position, z_min, z_max)
	
	camera.position.z = lerpf(
		camera.position.z, 
		z_position, 
		delta * z_speed
	)

#	if dragging:
		
	# tween setup: kill previous and create new one
	var tween
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT).set_parallel(true)
	
	# limit the vertical rotation
	v_rotation = clamp(v_rotation, v_min, v_max)
	
	# move and ease the horizontal camera
	tween.tween_property(
		$Horizontal,
		"rotation_degrees:y",
		h_rotation,
		delta * h_speed
	)
	
	# move and ease the vertical camera
	tween.tween_property(
		$Horizontal/Vertical,
		"rotation_degrees:x",
		v_rotation,
		delta * v_speed
	)
	

#		$Horizontal.rotation_degrees.y = lerpf(
#			$Horizontal.rotation_degrees.y, 
#			camrot_h, 
#			delta * h_acceleration
#		)
#
#		$Horizontal/Vertical.rotation_degrees.x = lerpf(
#			$Horizontal/Vertical.rotation_degrees.x, 
#			camrot_v, 
#			delta * v_acceleration
#		)
