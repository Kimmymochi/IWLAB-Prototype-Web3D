extends Node2D

signal close_clicked


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	position = get_viewport().get_camera_3d().unproject_position(target_node.global_position)
	visible = not SolarSettings.in_planet_view.is_empty() 

func _on_button_pressed():
	close_clicked.emit()
	
	SolarSettings.in_planet_view = ""
	SolarSettings.global_camera.change_current()
