@tool
extends Node

var speed_factor : float = 1:
	get:
		return speed_factor if in_planet_view.is_empty() else 0.01
		
	set(value):
		speed_factor = value
		speed_factor_updated.emit()


var in_planet_view : String = "":
	set(value):
		in_planet_view = value
		planet_view_toggled.emit()
		speed_factor_updated.emit()
		
		

var global_camera : SolarCamera

signal speed_factor_updated
signal planet_view_toggled

