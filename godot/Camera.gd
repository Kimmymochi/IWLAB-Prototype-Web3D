extends Node3D

var dragging = false

var camrot_h = 0
var camrot_v = 0
var cam_v_max = 75
var cam_v_min = -55
var h_sensitivity = 0.1
var v_sensitivity = 0.1
var h_acceleration = 50
var v_acceleration = 50

@onready var camera : Camera3D = $Horizontal/Vertical/Camera3D

func _input(event):

	if event.is_action_pressed("ZoomIn"):
		camera.fov = lerpf(camera.fov, 15.0, 0.25)

		
	elif event.is_action_pressed("ZoomOut"):
		camera.fov = lerpf(camera.fov, 100.0, 0.25)

		
	elif event.is_action("Drag"):
		if event.is_pressed():
			dragging = true
			
		else:
			dragging = false
			
	elif event is InputEventMouseMotion and dragging:
		camrot_h += -event.relative.x * h_sensitivity
		camrot_v += event.relative.y * v_sensitivity
	
	


func _physics_process(delta):
	
	if dragging:
		camrot_v = clamp(camrot_v, cam_v_min, cam_v_max)
		var tween 
		
#		if tween:
#			tween.kill()
#
		# TODO: Change lerp to tween for easing?
		tween = create_tween().bind_node(self).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)

		tween.tween_property(
			$Horizontal,
			"rotation_degrees:y",
			camrot_h,
			delta * h_acceleration
		)

#		tween.tween_property(
#			$Horizontal/Vertical,
#			"rotation_degrees:x",
#			camrot_v,
#			delta * v_acceleration
#		)
##

		$Horizontal.rotation_degrees.y = lerpf(
			$Horizontal.rotation_degrees.y, 
			camrot_h, 
			delta * h_acceleration
		)

		$Horizontal/Vertical.rotation_degrees.x = lerpf(
			$Horizontal/Vertical.rotation_degrees.x, 
			camrot_v, 
			delta * v_acceleration
		)
