extends Node3D

@onready var camera : Camera3D = $Horizontal/Vertical/Camera3D

var dragging = false
var zooming = false

var h_rotation = 0
var h_sensitivity = 0.1
var h_speed = 30


var v_rotation = 0
var v_sensitivity = 0.1
var v_speed = 30
var v_min = -55
var v_max = 75


var zoom = 1
var zoom_sensitivity = 0.8
var zoom_speed = 20
var zoom_min = 40
var zoom_max = 1500

var events = {}
var last_drag_distance = 0





func _unhandled_input(event):
	
	# MOUSE EVENTS
	# -------------------------------
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				dragging = true
			else:
				dragging = false
		
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
#
#		elif events.size() == 2:
#			zooming = true
#			_change_cam_zoom()
#	else:
#		zooming = false




func _change_cam_rotation(event):
		h_rotation += -event.relative.x * h_sensitivity
		v_rotation += -event.relative.y * v_sensitivity

func _change_cam_zoom():
	var drag_distance = events.values()[0].position.distance_to(events.values()[1].position)
	if abs(drag_distance - last_drag_distance) > zoom_sensitivity:
		zoom = (1 + zoom_speed) if drag_distance < last_drag_distance else (1 - zoom_speed)
		last_drag_distance = drag_distance





func _physics_process(delta):
	


#		print(zoom_cam.x)
#
	

	if dragging:
#		if zooming:
#			zoom = clamp(camera.position.z * zoom, zoom_min, zoom_max)
#
#			var tween
#			if tween:
#				tween.kill()
#			tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT).set_parallel(true)
#
#			tween.tween_property(
#				camera,
#				"position:z",
#				zoom,
#				delta * zoom_speed
#			)
			
#			camera.position.z = lerpf(
#				camera.position.z, 
#				zoom, 
#				delta * zoom_speed
#			)
			
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
