extends Node3D

#var rotating = false
#
#var prev_position
#var next_position
#
#func _process(delta):
#
#	if(Input.is_action_just_pressed("Rotate")):
#		rotating = true
#		prev_position = get_viewport().get_mouse_position()
#		print('true')
#
#	if(Input.is_action_just_released("Rotate")):
#		rotating = false
#
#	if (rotating):
#		next_position = get_viewport().get_mouse_position()
#		rotate_x((next_position.y - prev_position.y) * .2 * delta)
#		rotate_y(-(next_position.x - prev_position.x) * .2 * delta)
#		prev_position = next_position
