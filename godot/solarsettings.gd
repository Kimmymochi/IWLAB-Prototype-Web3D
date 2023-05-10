@tool
extends Node

# Animation speeds based on Earth
# 1 year  = 60 sec.
var orbital_speed : float = 120
# 1 day = 60 / 365 = 0.164 sec.
var rotation_speed : float = orbital_speed / 365
var object_distance = 60


var speed_factor : float = 1:
	get:
		return speed_factor if in_planet_view.is_empty() else 0.001
		
	set(value):
		speed_factor = value
		speed_factor_updated.emit()


var in_planet_view : String = "":
	set(value):
		in_planet_view = value
		planet_view_toggled.emit()
		speed_factor_updated.emit()




var global_camera : SolarCamera
var global_view : ObjectView

signal speed_factor_updated
signal planet_view_toggled

